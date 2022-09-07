resource "google_service_account" "sa" {
   for_each = toset(var.iam)

  account_id   = each.value
  display_name = each.value
}

variable "iam" {
    type       =  list(string)
    default = ["test-3" , "test-4"]
}

#=========================================================#

resource "google_service_account" "sa" {
  count = length(var.iam)
  account_id   = var.iam[count.index]
  display_name = var.iam[count.index]
}

variable "iam" {
    type       =  list(string)
    default = ["test-3" , "test-4"]
}

#==========================================================#

resource "google_service_account" "sa" {
   for_each = var.iam

  account_id   = each.value
  display_name = each.value
}

variable "iam" {
    type       =  set(string)
    default = ["test-3" , "test-4"]
}
