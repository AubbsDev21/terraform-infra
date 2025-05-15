resource "aws_instance" "this" {
    count = var.ec2_count
    ami = var.ami_id
    instance_type = var.instance_type

    subnet_id = element(var.subnet_id, count.index)
    availability_zone = var.availability_zone
    vpc_security_group_ids = var.vpc_security_group_ids

    user_data = var.user_data
    associate_public_ip_address = var.associate_public_ip_address

    tags = merge(var.tags, {
    Name = "${var.ec2_name}-${var.environment}-${count.index + 1}"
  })


}

#################################
########## Elastic IPs ############
#################################

resource "aws_eip" "this" {
  count = var.ec2_count
  instance = aws_instance.this[count.index].id
  associate_with_private_ip = aws_instance.this[count.index].private_ip

  depends_on = [ aws_instance.this ]
}