import os
import json 
import tempfile
from pathlib import Path

# access environment variable
# print(os.environ)
try:
    with open("data/serverconfig.json", "r") as file: 
        data = file.read()
        server_config = json.loads(data)

except json.JSONDecodeError:
    print("Error decoding json ")

try: 
    enviroment_varriables = os.environ
except os.EX_UNAVAILABLE: 
    print("Error reading enviorment varriables")

def write_json_atomic(path, data):
    path = Path(path)
    fd, tmp = tempfile.mkstemp(dir=path.parent, suffix=".tmp")
    try:
        with open(fd, "w") as f:
            f.write(data)
        
        os.replace(tmp, path)
        print("Config updated sucessfully!")
    except BaseException:
        os.remove(tmp)
        print("Config update failed...")
        raise


for setting in server_config: 
    for env in enviroment_varriables: 
        if setting == env:
            if server_config[setting] != os.environ.get(env):
                print("Setting:", setting, " To:", os.getenv(env))
                try: 
                    server_config[setting] = os.environ.get(env)
                    print("Set:", setting, " To:", os.getenv(env))
                except json.JSONDecodeError:
                    print("Error setting", setting)

updated_server_config = json.dumps(server_config, indent=4)

write_json_atomic("data/serverconfig.json", updated_server_config)
