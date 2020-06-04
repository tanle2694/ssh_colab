import requests
import re
import json
import os
url = "http://127.0.0.1:4040/http/in"

r = requests.get(url)
for line in r.text.split("\n"):
  if not line.__contains__("window.data"):
    continue
  r_match = re.match(r"^.*JSON\.parse\((.*)\);$", line)
  tunnel = json.loads(json.loads(r_match.group(1)))['UiState']['Tunnels'][0]
  port = tunnel['PublicUrl'][7:]
  print("ssh root@{} -p {}".format(os.environ['IP_SERVER'], port))