from http.server import HTTPServer, SimpleHTTPRequestHandler

class COOPHandler(SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header("Cross-Origin-Opener-Policy", "same-origin")
        self.send_header("Cross-Origin-Embedder-Policy", "require-corp")
        super().end_headers()

if __name__ == "__main__":
    import sys
    from functools import partial
    import os
    os.chdir("out/web")  # serve your web build folder
    httpd = HTTPServer(("localhost", 8080), COOPHandler)
    print("Serving on http://localhost:8080")
    httpd.serve_forever()
