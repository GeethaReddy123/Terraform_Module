# Define SSH key pair for our instances
resource "aws_key_pair" "default" {
  key_name = "devops_key"
  public_key = "${file("${var.key_path}")}"
}

# Define Jenkins Server inside the public subnet
resource "aws_instance" "wb" {
   ami  = "${var.ami}"
   instance_type = "t2.micro"
   key_name = "${aws_key_pair.default.id}"
   subnet_id = "${var.subnet_id}"
   vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
   associate_public_ip_address = true
   source_dest_check = false

   connection {
   host        = "${self.public_ip}"
   user        = "ubuntu"
   agent       = false
   private_key = "${file("${var.pem_file}")}"
   }

   provisioner "file" {
    source      = "ec2/docker_install.sh"
    destination = "/tmp/docker_install.sh"
    }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/docker_install.sh",
      "/tmp/docker_install.sh",
    ]
  }

  tags = {
    Name = "Docker Container Host Machine"
  }
}

output "instance_id" {
  value = "${aws_instance.wb.id}"
}
