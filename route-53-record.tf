resource "aws_route53_record" "cname_record" {
  zone_id = aws_route53_zone.sivaprakash_info.zone_id
  name    = "web-app"  # Replace with your desired subdomain
  type    = "CNAME"
  ttl     = "120"
  records = [aws_lb.alb.dns_name]
}
