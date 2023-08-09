# Setting up AWS as the provider
provider "aws" {
  region = "me-south-1"  # Setting up the region to be Bahrain
}

# Creating two EC2 instances (Virtual Machines)
resource "aws_instance" "OrangeVM" {
  count = 2                      # Creating 2 VMs
  ami = "ami-0a54c984b4be77330"  # Amazon Machine Image (AMI) (this one is just an arbitrary example for an amazon linux 2 AMI)
  instance_type = "t2.micro"     # t2.micro gives the virtual machine(s) 1 CPU and 1 GB of RAM
}

# Creating two EBS volumes (Storage components)
resource "aws_ebs_volume" "OrangeVolume" {
  count = 2                         # Creating 2 EBS volumes
  availability_zone = "me-south-1"  # Setting the availability zone to be Bahrain
  size = 5                          # Setting the size of the volume to be 5 GB
}

# Attaching the EBS volumes to the EC2 instances
resource "aws_volume_attachment" "OrangeAttachment" {
  device_name = "/dev/sdf"  # "/dev/sdf" is the default name for the first EBS volume in linux
  volume_id = aws_ebs_volume.OrangeVolume.id
  instance_id = aws_instance.OrangeVM.id
}

resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "My terraform vpc "
    }
}
resource "aws_subnet" "public subnet" {
    vpc_id = aws_vpc.myvpc.vpc_id
    cidr_block = "10.0.1.0/24"
}
resource "aws_subnet" "private subnet" {
    vpc_id = aws_vpc.myvpc.vpc_id
    cidr_block = "10.0.2.0/24"
}
resource "aws_internet_gateway" "igw"{
    vpc_id = "aws_vpc.myvpc.id"
}
resource "aws_route_table" "public RT"{
    vpc_id = "aws_vpc.myvpc.id"
    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
}
resource "aws_route_table_association" "publicRT association"{
subnet_id = aws_subnet.publicsubnet.id
route_table_id = aws_route_table.publicRT.id 
}