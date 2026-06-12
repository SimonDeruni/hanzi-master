const fs = require('fs');
const https = require('https');
const zlib = require('zlib');
const sqlite3 = require('sqlite3').verbose();
const path = require('path');

const url = 'https://www.mdbg.net/chinese/export/cedict/cedict_1_0_ts_utf-8_mdbg.txt.gz';
const dbPath = path.join(__dirname, '../assets/data/dictionary.db');

// Ensure assets/data exists
if (!fs.existsSync(path.dirname(dbPath))) {
  fs.mkdirSync(path.dirname(dbPath), { recursive: true });
}

// Delete existing DB if it exists
if (fs.existsSync(dbPath)) {
  fs.unlinkSync(dbPath);
}

const db = new sqlite3.Database(dbPath);

db.serialize(() => {
  db.run(`
    CREATE TABLE words (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      traditional TEXT,
      simplified TEXT,
      pinyin TEXT,
      pinyin_no_tones TEXT,
      definition TEXT
    )
  `);

  db.run(`CREATE INDEX idx_simplified ON words(simplified)`);
  db.run(`CREATE INDEX idx_pinyin ON words(pinyin_no_tones)`);
  db.run(`CREATE INDEX idx_definition ON words(definition)`);

  console.log('Downloading CC-CEDICT...');

  https.get(url, (res) => {
    const gunzip = zlib.createGunzip();
    res.pipe(gunzip);

    let leftover = '';
    let count = 0;

    db.run('BEGIN TRANSACTION');
    const stmt = db.prepare('INSERT INTO words (traditional, simplified, pinyin, pinyin_no_tones, definition) VALUES (?, ?, ?, ?, ?)');

    gunzip.on('data', (chunk) => {
      const lines = (leftover + chunk.toString('utf8')).split('\n');
      leftover = lines.pop();

      for (let line of lines) {
        line = line.trim();
        if (line.startsWith('#') || line === '') continue;

        // Format: Traditional Simplified [pin1 yin1] /definition 1/definition 2/
        const match = line.match(/^(\S+)\s+(\S+)\s+\[(.+?)\]\s+\/(.+)\/$/);
        if (match) {
          const traditional = match[1];
          const simplified = match[2];
          const pinyin = match[3];
          const definition = match[4].replace(/\//g, '; ');
          
          // Create a searchable pinyin string without tone numbers
          const pinyinNoTones = pinyin.replace(/\d/g, '').replace(/\s+/g, '').toLowerCase();

          stmt.run(traditional, simplified, pinyin, pinyinNoTones, definition);
          count++;
        }
      }
    });

    gunzip.on('end', () => {
      stmt.finalize();
      db.run('COMMIT', () => {
        console.log(`Inserted ${count} words into the database.`);
        db.close();
      });
    });

    gunzip.on('error', (err) => {
      console.error('Extraction error:', err);
    });
  }).on('error', (err) => {
    console.error('Download error:', err);
  });
});
