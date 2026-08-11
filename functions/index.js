const { onRequest } = require("firebase-functions/v2/https");
const fetch = require("node-fetch");
const cors = require("cors")({ origin: true });

exports.generateContentProxyV2 = onRequest({ cors: true, invoker: "public" }, (req, res) => {
  cors(req, res, async () => {
    if (req.method !== "POST") {
      return res.status(405).send("Method Not Allowed");
    }

    const apiKey = process.env.GEMINI_API_KEY;
    if (!apiKey) {
      return res.status(500).json({ error: "Missing Gemini API Key" });
    }

    try {
      const { model, body } = req.body;
      const targetModel = model || "gemini-2.5-flash";
      const url = `https://generativelanguage.googleapis.com/v1beta/models/${targetModel}:generateContent?key=${apiKey}`;

      const response = await fetch(url, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(body),
      });

      const data = await response.json();
      return res.status(response.status).json(data);
    } catch (error) {
      console.error("Proxy error:", error);
      return res.status(500).json({ error: "Internal Server Error" });
    }
  });
});

exports.openRouterProxyV2 = onRequest({ cors: true, invoker: "public" }, (req, res) => {
  cors(req, res, async () => {
    if (req.method !== "POST") {
      return res.status(405).send("Method Not Allowed");
    }

    // Use the perfectly working Gemini API key instead of the broken OpenRouter key
    const apiKey = process.env.GEMINI_API_KEY;
    if (!apiKey) {
      return res.status(500).json({ error: "Missing Gemini API Key" });
    }

    try {
      // Use Gemini's official OpenAI-compatible endpoint
      const url = "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions";
      
      // Intercept the request and force the model to Gemini 2.5 Flash, ignoring any OpenRouter models
      const requestBody = { ...req.body, model: "gemini-2.5-flash" };

      const response = await fetch(url, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "Authorization": `Bearer ${apiKey}`
        },
        body: JSON.stringify(requestBody),
      });

      if (req.body.stream) {
        res.setHeader("Content-Type", "text/event-stream");
        res.setHeader("Cache-Control", "no-cache");
        res.setHeader("Connection", "keep-alive");
        res.status(response.status);
        response.body.pipe(res);
      } else {
        const data = await response.json();
        return res.status(response.status).json(data);
      }
    } catch (error) {
      console.error("Proxy error:", error);
      return res.status(500).json({ error: "Internal Server Error" });
    }
  });
});
