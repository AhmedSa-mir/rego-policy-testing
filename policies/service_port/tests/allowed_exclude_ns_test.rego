package example

testcase3 = {
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
      "name": "my-service",
      "namespace": "test_ns"
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

test_service_port_allowed_exclude_ns {
    not deny with input as testcase3.entity with input.parameters as testcase3.parameters
}