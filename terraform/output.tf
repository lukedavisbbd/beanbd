output "beanbd_db_endpoint" {
  value = aws_db_instance.beanbd_instance.endpoint
}

output "beanbd_db_address" {
  value = aws_db_instance.beanbd_instance.address
}

output "beanbd_db_port" {
  value = aws_db_instance.beanbd_instance.port
}
