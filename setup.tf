module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a"]
  public_subnets  = ["10.0.101.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "web_server_sg"{
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  depends_on = [
    module.vpc
  ]

  name                = "Public security group"
  description         = "Allow SSH"
  vpc_id              = module.vpc.vpc_id
  ingress_cidr_blocks = ["10.0.101.0/24"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}


resource "aws_key_pair" "terraform_ec2_key" {
  
  key_name   = "terraform_ec2_key"
  public_key = "${file("terraform_ec2_key.pub")}"
}

module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"
  depends_on = [
    module.web_server_sg.public_security_group
  ]
  count                       = 2
  name                        = "Slave machines"
  ami                         = "ami-0e4a6983add08ad9c"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.terraform_ec2_key.key_name
  monitoring                  = true
  associate_public_ip_address = true
  vpc_security_group_ids      = [module.web_server_sg.security_group_id]
  subnet_id                   = module.vpc.public_subnets[0]

}

output "ip" {
  value = module.ec2_instance[*].public_ip
}
