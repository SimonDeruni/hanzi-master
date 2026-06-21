const WebSocket = require("ws");
const ws = new WebSocket("wss://generativelanguage.googleapis.com/ws/google.ai.generativelanguage.v1beta.GenerativeService.BidiGenerateContent?key=AQ.Ab8RN6ITpt4TEoB6qHCPdimZB-QQBHWumenEP5OMfir2og9GVA");
ws.on("open", () => {
  console.log("Connected v1beta 3.5");
  ws.send(JSON.stringify({setup: {model: "models/gemini-3.5-live-translate-preview"}}));
});
ws.on("message", (data) => console.log(data.toString()));
ws.on("error", (e) => console.error(e));
ws.on("close", (code, reason) => console.log("Closed:", code, reason.toString()));
