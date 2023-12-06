resource "aws_route53_record" "cname_record" {
  zone_id = "Z048191423B1RB1MAJP3Z"
  name    = "web-app"  # Replace with your desired subdomain
  type    = "CNAME"
  ttl     = "120"
  records = [aws_lb.alb.dns_name]
}
