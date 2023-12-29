# to call random string.myrandomstring.id
resource "random_string" "myrandomstring" {
  length  = 6
  special = false
  upper   = false
  numeric = false
}
