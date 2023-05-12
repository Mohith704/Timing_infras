module "VPC" {
    source = "../VPC"
    vpc_cidr = var.vpc_cidr
    tags = var.tags
    azs = var.azs

    #Public_subnet
    public_subnet_cidr = var.public_subnet_cidr
    public_subnet_names = var.public_subnet_names
    igw_cidr = var.igw_cidr
    public_route_tbl_name = local.public_route_tbl_name

    #Private_subnet
    private_subnet_cidr = var.private_subnet_cidr
    private_subnet_names = var.private_subnet_names
    private_route_tbl_name = local.private_route_tbl_name

    #Database_subnet
    database_subnet_cidr = var.database_subnet_cidr
    database_subnet_names = var.database_subnet_names
    database_route_tbl_name = local.database_route_tbl_name
}
