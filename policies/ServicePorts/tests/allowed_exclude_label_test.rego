package magalix.advisor.services.block_ports

test_service_port_allowed_exclude_label {
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
          "name": "my-service",
          "labels":{
            "test_label": "OK"
          }
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
  
  count(violation) == 0 with input as testcase
}