resource "aws_instance" "project-vm" {
    ami = "${var.ami_id}"
    instance_type = "${var.instance_type}"
    tags = {
        Name = "${var.project_name}-vm"
    }
}