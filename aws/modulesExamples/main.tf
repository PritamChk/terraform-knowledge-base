module "appVm-1" {
  source        = "./modules/vm"
  project_name  = "app1"
  ami_id        = "ami-01ca13db604661046"
  instance_type = "t2.micro"
  
}
module "dbVm-1" {
  source        = "./modules/vm"
  project_name  = "db1"
  ami_id        = "ami-01ca13db604661046"
  instance_type = "t2.micro"
  
}