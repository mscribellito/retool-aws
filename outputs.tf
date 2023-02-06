output "dns_name" {
  value       = aws_lb.retool.dns_name
  description = "The DNS name of the load balancer."
}