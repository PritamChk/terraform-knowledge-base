locals {
  provider = "aws"
  os       = "ubuntu"
  size     = "medium"
}

resource "aws_instance" "vm" {
  ami           = var.cloud_catalog[local.provider].os_images[local.os]
  instance_type = var.cloud_catalog[local.provider].instance_types[local.size]
}
