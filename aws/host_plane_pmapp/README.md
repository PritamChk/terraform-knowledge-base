## Goal 1: Deploy a dockerized application to a EC2 instance using `Terraform`

---

> Architecture I'm trying to achieve here:
>
> ![arch-diag-1-404](imgs/image-11.png)

### Key learnings in Goal 1

---

- Learning of data source aws_ami --> fetch details of latest ami for aws 2023 linux

- S3 backend setup for terraform

- EC2 Provisioning using life-cycle like prevent destroy for the VM
- Validation for variable
  - ![alt text](imgs/image-5.png)
- Validation for All TF Files

  > First Validation:
  >
  > ![validation-1-failed-img-404](imgs/image.png)

- Setup a docker containerized app through script provisioning

link : [Reference to HCL Doc](https://developer.hashicorp.com/packer/docs/templates/hcl_templates/blocks/build/provisioner)

- All TF file formatting

> Before Formatting
> ![b4-fmt-code-404](imgs/image-2.png)

> After Formatting
> ![alt text](imgs/image-4.png)
>
> ![after-fmt-code-404](imgs/image-3.png)

- terraform workspace for environment specific
  - ![workspace-tf-404](imgs/image-6.png)
  - ![ws-tf-2-404](imgs/image-7.png)
- Complex Variable Tag
  - ![tag-complex-data-404](imgs/image-8.png)
- Issue faced with docker compose installation and check
- Finally app is up
  - ![app-up-404](imgs/image-9.png)
  - ![app-up-large-time-404](imgs/image-10.png)
