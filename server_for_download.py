import http.server as BaseHTTPServer
import os
import shutil
import argparse


class SimpleHTTPRequestHandler(BaseHTTPServer.BaseHTTPRequestHandler):
    def do_GET(self):
        with open(FILEPATH, 'rb') as f:
            self.send_response(200)
            self.send_header("Content-Type", 'application/octet-stream')
            self.send_header("Content-Disposition", 'attachment; filename="{}"'.format(os.path.basename(FILEPATH)))
            fs = os.fstat(f.fileno())
            self.send_header("Content-Length", str(fs.st_size))
            self.end_headers()
            shutil.copyfileobj(f, self.wfile)

if __name__ == '__main__':
    parse = argparse.ArgumentParser()
    parse.add_argument("--port", default=8001, type=int)
    parse.add_argument("--file", required=True)
    args = parse.parse_args()
    port = args.port
    FILEPATH = args.file
    server_address = ('', port)
    ServerClass = BaseHTTPServer.HTTPServer,
    protocol="HTTP/1.0"
    SimpleHTTPRequestHandler.protocol_version = protocol
    httpd = BaseHTTPServer.HTTPServer(server_address, SimpleHTTPRequestHandler)
    sa = httpd.socket.getsockname()
    print("Serving HTTP on {0[0]} port {0[1]} ... {1}".format(sa, FILEPATH))
    httpd.serve_forever()