resource "aws_instance" "tf-first-vm" {
    ami = "ami-00ca570c1b6d79f36"
    instance_type = "t2.micro"
    tags = {
      Name = "Test-VM-1"
    }
}