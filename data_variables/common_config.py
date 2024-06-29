import os.path

CUR_DIR = os.getcwd()

# BROWSER to run test
BROWSER = "Chrome"
# BROWSER = "Firefox"

FF_BINARY = "C:/Program Files/Mozilla Firefox/firefox.exe"

LOCALHOST_PROXY = "http://localhost:8000"
PROXY_BYPASS = "stg.*.com;*payvault*;*.cloudfare.com;"

DOWNLOAD_DIR = os.path.join(CUR_DIR, "results", "downloads")
