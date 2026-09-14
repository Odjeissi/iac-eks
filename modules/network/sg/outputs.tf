output "allow_db_traffic_arn" {
  value = aws_security_group.allow_db_traffic.arn
}

output "allow_db_traffic_id" {
  value = aws_security_group.allow_db_traffic.id
}
