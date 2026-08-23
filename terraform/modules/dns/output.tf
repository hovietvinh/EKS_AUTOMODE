output "zone_id" {
  value = aws_route53_zone.this.zone_id
}
output "common_zone_nameservers" {
  value = aws_route53_zone.this.name_servers
}