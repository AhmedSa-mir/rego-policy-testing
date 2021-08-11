package example

target_port := input.parameters.target_port
exclude_namespace := input.parameters.exclude_namespace
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

deny {
  not exclude_namespace == input.metadata.namespace
  not exclude_label_value == input.metadata.labels[exclude_label_key]
  some i
  spec_port := service_spec.ports[i]
  service_port := spec_port.targetPort
  not service_port > target_port
}

service_spec = input.spec {
  contains_kind(input.kind, {"Service"})
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}