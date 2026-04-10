import http from "node:http";

const port = Number.parseInt(process.env.PORT ?? "8080", 10);

const server = http.createServer((req, res) => {
  if (req.url === "/" && req.method === "GET") {
    res.writeHead(200, { "content-type": "text/plain; charset=utf-8" });
    res.end("FinCorp supply-chain demo");
    return;
  }

  res.writeHead(404, { "content-type": "text/plain; charset=utf-8" });
  res.end("Not found");
});

server.listen(port, "0.0.0.0", () => {
  // eslint-disable-next-line no-console
  console.log(`listening on :${port}`);
});

