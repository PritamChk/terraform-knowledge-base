resource "aws_instance" "tf-first-vm" {
    ami = "${var.RHELinux10}"
    instance_type = "${var.InstanceType["freeVM"]}"
    tags = {
      Name = "Test-VM-1"
    }
}