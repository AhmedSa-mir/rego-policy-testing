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

- The testcase function should be named as `test_xyz`

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
`opa test policies/ -v`
