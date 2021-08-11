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
