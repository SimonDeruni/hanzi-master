const fs = require('fs');

async function main() {
  const apiKey = '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';
  
  const filesToProcess = [
    'assets/data/1000_stories_en.json',
    'assets/data/tang_poetry_en.json',
    'assets/data/mandarin_bean_stories.json'
  ];

  for (const dataPath of filesToProcess) {
    if (!fs.existsSync(dataPath)) continue;
    let data = JSON.parse(fs.readFileSync(dataPath, 'utf8'));
    
    const batchSize = 50;
    console.log(`Starting translation of ${data.length} items in ${dataPath} using DeepSeek...`);
    
    for (let i = 0; i < data.length; i += batchSize) {
      const batch = data.slice(i, i + batchSize);
      
      const itemsToTranslate = batch.map((item, index) => ({
        id: index,
        title_zh: item.title,
        summary_zh: item.summary
      }));
      
      const prompt = `You are an expert Chinese-to-English translator. 
I have a list of Chinese stories and their summaries. The current English translations are missing, too literal, or unnatural.
Provide a highly natural, culturally appropriate English title and a clear, fluid English translation for the summary.
Respond ONLY with a valid JSON array of objects in this exact format, with no markdown formatting:
[
  {
    "id": 0,
    "title_en": "Natural English Title",
    "summary_en": "Clear English Summary"
  }
]
Here is the data:
${JSON.stringify(itemsToTranslate, null, 2)}`;

      let success = false;
      let retries = 0;
      
      while (!success && retries < 3) {
        try {
          console.log(`Translating batch ${i/batchSize + 1} of ${Math.ceil(data.length/batchSize)} for ${dataPath}...`);
          const response = await fetch("https://openrouter.ai/api/v1/chat/completions", {
            method: "POST",
            headers: {
              "Authorization": `Bearer ${apiKey}`,
              "Content-Type": "application/json"
            },
            body: JSON.stringify({
              model: "deepseek/deepseek-chat",
              messages: [{ role: "user", content: prompt }]
            })
          });
          
          const result = await response.json();
          if (!result.choices) {
            throw new Error("OpenRouter error: " + JSON.stringify(result));
          }
          let content = result.choices[0].message.content.trim();
          
          if (content.startsWith("\`\`\`json")) {
            content = content.replace(/^\`\`\`json\n?/, "").replace(/\n?\`\`\`$/, "");
          } else if (content.startsWith("\`\`\`")) {
            content = content.replace(/^\`\`\`\n?/, "").replace(/\n?\`\`\`$/, "");
          }
          
          const translatedBatch = JSON.parse(content);
          
          for (const tItem of translatedBatch) {
            const originalItem = batch[tItem.id];
            originalItem.title_en = tItem.title_en;
            originalItem.summary_en = tItem.summary_en;
          }
          
          success = true;
        } catch (err) {
          retries++;
          console.error(`Error on batch ${i/batchSize + 1}, retrying (${retries}/3)...`, err.message);
        }
      }
      
      fs.writeFileSync(dataPath, JSON.stringify(data, null, 2));
    }
  }
  
  console.log("All translations complete!");
}

const envPath = '.env';
if (fs.existsSync(envPath)) {
  const envContent = fs.readFileSync(envPath, 'utf8');
  envContent.split('\n').forEach(line => {
    const [key, value] = line.split('=');
    if (key && value) {
      process.env[key.trim()] = value.trim();
    }
  });
}

main();
