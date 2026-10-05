resource "aws_key_pair" "openvpn" {
  key_name   = "openvpn"
  public_key = file("C://Users//anjis//Desktop//Devops/openvpn.pub")
}

resource "aws_instance" "openvpn" {
  ami                    = local.ami_id
  instance_type          = "t3.micro"
  source_dest_check      = false
  vpc_security_group_ids = [local.openvpn_sg_id]
  subnet_id              = local.public_subnet_id
  key_name               = aws_key_pair.openvpn.key_name
  user_data              = file("openvpn.sh")

  tags = merge(local.common_tags,
    {
      Name = "${var.project}-${var.environment}-vpn"
  })
}

resource "aws_route53_record" "vpn" {
  zone_id = var.zone_id
  name    = "vpn-${var.environment}.${var.zone_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.openvpn.public_ip]
  allow_overwrite = true
}