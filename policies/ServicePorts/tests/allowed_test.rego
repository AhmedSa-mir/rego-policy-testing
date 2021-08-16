package magalix.advisor.services.block_ports

test_service_port_allowed {
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
              "targetPort": 8000,
              "nodePort": 30007
            }
          ]
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}
