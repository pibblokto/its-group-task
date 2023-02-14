// include "root" {
//   path = find_in_parent_folders()
//   expose         = true
//   merge_strategy = "deep"
// }


// terraform {
//   source = "${dirname(find_in_parent_folders())}//Modules//RDS_Option_Group"
// }

// include "envcommon" {
//   path = "${dirname(find_in_parent_folders())}//env_common//project_envs.hcl"
// }




// inputs = {
//   engine_name          = "postgres"
//   major_engine_version = "13"

// }