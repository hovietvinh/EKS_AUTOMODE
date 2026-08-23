const http = require("http");

const SERVICE_NAME = "svc1";
const PORT = process.env.PORT || 3000;
const startedAt = new Date().toISOString();

const server = http.createServer((req, res) => {
  res.setHeader("Content-Type", "application/json");

  if (req.url === "/health" || req.url === "/healthz") {
    res.writeHead(200);
    res.end(JSON.stringify({ status: "ok" }));
    return;
  }

  if (req.url === "/getinfo") {
    res.writeHead(200);
    res.end(
      JSON.stringify({
        service: SERVICE_NAME,
        version: process.env.APP_VERSION || "dev",
        startedAt,
        hostname: require("os").hostname(),
      })
    );
    return;
  }

  res.writeHead(404);
  res.end(JSON.stringify({ error: "not found" }));
});

server.listen(PORT, () => {
  console.log(`[${SERVICE_NAME}] listening on port ${PORT}`);
});