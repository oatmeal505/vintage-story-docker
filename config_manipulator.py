import os
import json 
import tempfile
import ast
import re

from pathlib import Path
from deepdiff import DeepDiff
from copy import deepcopy

# access environment variable
# print(os.environ)

config_file_address = os.environ.get("USERNAME") + "/data/serverconfig.json"

try:
    with open(config_file_address, "r") as file: 
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

def contains_special_character(s):
    # Define a regex pattern for special characters
    pattern = re.compile('[^a-zA-Z0-9]')
    # Search for the pattern in the string
    return bool(pattern.search(s))

def filter_settings(setting, config): 
    for env in enviroment_varriables:             
            if setting == env:
                if config[setting] != os.environ.get(env):
                    if contains_special_character(os.environ.get(env)):
                        try: 
                            config[setting] = os.environ.get(env)
                        except json.JSONDecodeError:
                            print("Error setting", setting)
                    else: 
                        try: 
                            try:
                                true_value = ast.literal_eval(os.environ.get(env))
                            except ValueError:
                                true_value = os.environ.get(env)
                                config[setting] = true_value
                        except json.JSONDecodeError:
                            print("Error setting", setting)

def filter_dictionary_settings(dictionary): 
    for item in dictionary:
        filter_settings(item, dictionary)

def filter_list_settings(setting, list): 
    for env in enviroment_varriables:
        try: 
            env_split = env.split("_", 2)
            env_name = env_split[0]
                        
        except:
            continue   

        match setting:
            case "Roles":
                try: 
                    code = env_split[1]
                    option = env_split[2]
                    value = os.getenv(env)
                except:
                    continue
                for entry in list:
                    if entry["Code"] == code:
                        if entry[option] != value:
                            try:
                                try:
                                    true_value = ast.literal_eval(os.environ.get(env))
                                except ValueError:
                                    true_value = os.environ.get(env)
                                
                                entry[option] = true_value
                            except:
                                print("ERROR SETTING:", setting, "please make sure you are not trying to set any forbiden characters", )            

            case "ModPaths": 
                if setting == env:
                    env_value = (os.getenv(env)).split(":", 2)
                    json_value = deepcopy(list)
                    if env_value[0] != json_value[0] or env_value[1] != json_value[1]: 
                        list[0] = env_value[0]        
                        list[1] = env_value[1]              

            case _: 
                continue

def filter_last_launch_mods(setting, list, data): 

    tmplist = deepcopy(list)
    json_list = json.loads(tmplist)

    for env in enviroment_varriables:
        try: 
            env_split = env.split("_", 3)
            env_name = env_split[0]
        except:
            continue 

        if env_name == "LastLaunchMods":
            try: 
                id = env_split[1]
                option = env_split[2]
                value = os.getenv(env)
            except:
                continue
            
            for entry in json_list:
                # print(id)
                # print(entry["id"])
                if entry["id"] == id:
                    if entry[option] != value:
                        try: 
                            entry[option] = value
                        except json.JSONDecodeError:
                            print("Error setting", setting)  

    if json_list != list:
        data[setting] = (json.dumps(json_list)).replace(" ", "")


def house_keeping(data):
    for env in enviroment_varriables:
        if env == "VERSION":
            last_launch_mods = data["LastLaunchMods"]

            tmplist = deepcopy(last_launch_mods)
            json_list = json.loads(tmplist)

            for entry in json_list:
                # print(id)
                # print(entry["id"])
                if entry["id"] == "game":
                    if entry["version"] != env:
                        if os.environ.get("UPDATE_CONFIRM") == "true":
                            os.environ["LastLaunchMods_game_version"] = env
                            os.environ["LastLaunchMods_creative_version"] = env
                            os.environ["LastLaunchMods_survival_version"] = env

                            os.environ["UPDATE_VERSION"]="true"
                    else:
                        os.environ["UPDATE_VERSION"]="False"
        elif env == "WHITELIST":
            match os.environ.get(env):
                case "true":
                    os.environ["OnlyWhitelisted"] = "False"
                    os.environ["WhitelistMode"] = "2"
                case "false":
                    os.environ["OnlyWhitelisted"] = "True"
                    os.environ["WhitelistMode"] = "1"

def main():

    data = deepcopy(server_config)

    house_keeping(data)

    for item in data: 
        if isinstance(data[item], dict): 
            # print("Found dictionary: ", item)
            # print("found dictionary setting!!: ", item, " with the following type: ", type(data[item]), " that contains: ", data[item])
            filter_dictionary_settings(data[item])        
        elif isinstance(data[item], list):
        #   print("Found list: ", item)
            filter_list_settings(item, data[item])
        elif item == "LastLaunchMods":
            filter_last_launch_mods(item, data[item], data)
        else:
            # print("found standard setting: ", item, " with the following type: ", type(data[item]), " that contains: ", data[item])
            # print("Found item: ", item, " that is: ", type(data[item]))
            filter_settings(item, data) 

    diff = DeepDiff(server_config, data)
    print("---------------------------------------------------")
    print("Adjusted the following settings:", diff)
    print("---------------------------------------------------")
    if not diff:
        print("Server config not updated, configs identical") 
    else:
        updated_server_config = json.dumps(data, indent=4)
        write_json_atomic("data/serverconfig.json", updated_server_config)
    print("---------------------------------------------------")

main()
