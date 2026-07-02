const fs = require('fs');
const trim = (file) => {
  if (!fs.existsSync(file)) return;
  let d = JSON.parse(fs.readFileSync(file, 'utf8'));
  if (d.length > 150) {
    fs.writeFileSync(file, JSON.stringify(d.slice(0, 150), null, 2));
    console.log("Trimmed " + file + " to 150 items.");
  } else {
    console.log(file + " has " + d.length + " items.");
  }
};
trim('assets/data/1000_stories.json');
trim('assets/data/1000_stories_en.json');
trim('assets/data/tang_poetry_en.json');
