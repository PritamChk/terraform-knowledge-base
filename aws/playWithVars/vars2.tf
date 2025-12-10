variable "cloud_catalog" {
  type = map(object({
    os_images = map(string)
    instance_types = map(string)
  }))
  
  default = {
    aws = {
      os_images = {
        rhel   = "ami-079db87dc4c10ac91"
        ubuntu = "ami-05c3dc660cbf422d7"
      }

      instance_types = {
        freeTier = "t2.micro"
        small    = "t3.small"
        medium   = "t3.medium"
        large    = "t3.large"
        xlarge   = "t3.xlarge"
      }
    }

    azure = {
      os_images = {
        rhel   = "RedHat:RHEL:9-gen2:latest"
        ubuntu = "Canonical:0001-com-ubuntu-server-jammy:22_04-lts:latest"
      }

      instance_types = {
        freeTier = "Standard_B1s"
        small    = "Standard_B2s"
        medium   = "Standard_D2s_v3"
        large    = "Standard_D4s_v3"
        xlarge   = "Standard_D8s_v3"
      }
    }

    gcp = {
      os_images = {
        rhel   = "projects/rhel-cloud/global/images/family/rhel-9"
        ubuntu = "projects/ubuntu-os-cloud/global/images/family/ubuntu-2204-lts"
      }

      instance_types = {
        freeTier = "e2-micro"
        small    = "e2-small"
        medium   = "e2-medium"
        large    = "n1-standard-4"
        xlarge   = "n1-standard-8"
      }
    }

    oracle = {
      os_images = {
        rhel   = "ocid1.image.oc1..rhel9-latest"
        ubuntu = "ocid1.image.oc1..ubuntu22-04"
      }

      instance_types = {
        freeTier = "VM.Standard.E2.1.Micro"
        small    = "VM.Standard.E2.1"
        medium   = "VM.Standard.E2.2"
        large    = "VM.Standard.E4.4"
        xlarge   = "VM.Standard.E4.8"
      }
    }
  }
}
