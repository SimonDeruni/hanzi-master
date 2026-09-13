#!/usr/bin/env python3
"""
Hanzi Master - Desktop Web Audiobook Player Server
Serves the web player and the assets/data directory (books, catalog, dictionary)
with CORS enabled and opens the web player directly in your browser.
"""

import http.server
import os
import socketserver
import sys
import webbrowser

PORT = 8088
ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))

class CorsHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=ROOT_DIR, **kwargs)

    def end_headers(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', '*')
        self.send_header('Cache-Control', 'no-cache, no-store, must-revalidate')
        super().end_headers()

    def do_OPTIONS(self):
        self.send_response(200)
        self.end_headers()

    def log_message(self, format, *args):
        # Suppress routine log noise for cleaner terminal output
        if '200 -' in format % args:
            return
        super().log_message(format, *args)

def main():
    global PORT
    server = None
    for p in range(PORT, PORT + 20):
        try:
            server = socketserver.TCPServer(('127.0.0.1', p), CorsHandler)
            PORT = p
            break
        except OSError:
            continue

    if not server:
        print("❌ Error: Could not find an available port between 8088 and 8108.")
        sys.exit(1)

    url = f"http://127.0.0.1:{PORT}/web_audiobook/"
    print("=" * 64)
    print(" 🌸 Hanzi Master - Zen & Ink Desktop Audiobook Player 🌸")
    print("=" * 64)
    print(f" ▶ Server running at: {url}")
    print(f" ▶ Serving repository assets from: {ROOT_DIR}")
    print(" ▶ Press Ctrl+C in this terminal to stop the player server.")
    print("=" * 64)

    # Open the browser automatically
    webbrowser.open(url)

    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\n\n⏹ Stopping Hanzi Master Audiobook Server. Goodbye!\n")
        server.shutdown()

if __name__ == '__main__':
    main()
