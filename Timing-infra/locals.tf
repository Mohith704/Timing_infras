locals {   #Projname - public
  public_route_tbl_name = format("%s-%s",lookup(var.tags,"Name"), "public")
  private_route_tbl_name = format("%s-%s",lookup(var.tags,"Name"), "private")
  database_route_tbl_name = format("%s-%s",lookup(var.tags,"Name"), "database")
}

