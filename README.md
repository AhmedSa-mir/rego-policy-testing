# Rego Policy testing using `opa test`

## Directory Structure
```
.
├── policies
    ├── policy1
        ├── policy.rego     # Rego code for policy
        ├── tests           # Test files
            ├── x_test.rego
            ├── y_test.rego
            ├── z_test.rego
            ├── ...
    ├── policy2
    ├── ...
└── yaml_to_json.py         # converts yml entities into json objects
```

### Notes:
- Each test file contains a testcase with its input data. The input data contains:
    1. Parameters in which you can pass parameters to your rego code.
    2. Entity in which you put your entity json object.

- The testcase function should be named as `test_xyz`. This is OPA's test convention.
- The Yaml-to-Json parser checks for files under `policies/<policy_dir>/tests/xyz.yml` and generates the json object in `policies/<policy_dir>/tests/xyz.rego`

## Example test file

```
package example

testcase1 = {
    "parameters": {
        "target_port": 1024,
        "exclude_namespace": "test_ns",
        "exclude_label_key": "test_label",
        "exclude_label_value": "OK"
    },
    "entity": {
        "apiVersion": "v1",
        "kind": "Service",
        "metadata": {
        "name": "my-service"
        },
        "spec": {
        "type": "NodePort",
        "selector": {
            "app": "MyApp"
        },
        "ports": [
            {
            "port": 80,
            "targetPort": 80,
            "nodePort": 30007
            }
        ]
        }
    }
}

test_service_port_denied {
    deny with input as testcase1.entity with input.parameters as testcase1.parameters
}
```

## Running your tests

Install opa binary first (this is the linux binary):
```
curl -L -o opa https://openpolicyagent.org/downloads/v0.31.0/opa_linux_amd64_static
chmod 755 ./opa
mv opa /usr/local/bin/opa
```

Then run the tests in the policies dir:

`opa test policies/ -v`

Output sample:
```
data.example.test_service_port_allowed_exclude_label: PASS (1.348983ms)
data.example.test_service_port_allowed_exclude_ns: PASS (545.171µs)
data.example.test_service_port_allowed: PASS (919.811µs)
data.example.test_service_port_denied: PASS (1.257073ms)
--------------------------------------------------------------------------------
PASS: 4/4
```
