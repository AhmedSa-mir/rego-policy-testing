
import os
import yaml
import json

rootdir = 'policies/'

# Loop over policies test dirs and convert each test yaml file to json
def convert_test_yamls_to_json(rootdir):
    for policy_dir in os.listdir(rootdir):
        tests_dir_path = os.path.join(rootdir, policy_dir, "tests")
        if os.path.exists(tests_dir_path):
            # Loop over test files and convert them to json one by one
            for test_file in os.listdir(tests_dir_path):
                file_ext = os.path.splitext(test_file)[1]
                if file_ext in [".yml", ".yaml"]:
                    # Read YAML
                    with open(os.path.join(tests_dir_path, test_file)) as infile:
                        data_obj = yaml.load(infile, Loader=yaml.FullLoader)
                        data_obj = {"parameters": {}, "entity": data_obj}
                        json_filename = test_file.replace(".yaml", ".rego")
                        json_filename = test_file.replace(".yml", ".rego")
                        # Write JSON to .rego file to be compatible with opa test command
                        with open(os.path.join(tests_dir_path, json_filename), 'w') as outfile:
                            json.dump(data_obj, outfile, indent=2)

convert_test_yamls_to_json(rootdir)