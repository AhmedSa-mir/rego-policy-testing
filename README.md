# Rego Policy testing using `opa test`

## Directory Structure
```
.
├── policies
    ├── policy1
        ├── constraints
        ├── template
        ├── tests
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
- You can put multiple testcases in one file
- The testcase function should be named as `test_xyz`
- You can skip testcases from being run by naming it `todo_xyz`

## Example test file

```
package magalix.advisor.services.block_ports

test_service_port_violation {
  testcase = {
    "parameters": {
        "target_port": 1024,
        "exclude_namespace": "test_ns",
        "exclude_label_key": "test_label",
        "exclude_label_value": "OK"
    },
    "review": {
      "object": {
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
  }
  
  violation with input as testcase
}
```

## Running your tests
`opa test policies/ -v`
