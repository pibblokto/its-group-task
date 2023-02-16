// include "root" {
//   path = find_in_parent_folders()
//   expose         = true
//   merge_strategy = "deep"
// }


// terraform {
//   source = "${dirname(find_in_parent_folders())}//Modules//AWS_S3"
// }


// inputs = {
//   acl = "private"
//   versioning_status = "Enabled"
// }