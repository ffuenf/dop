name "vagrant_provision"
description "vagrant"
run_list "recipe[dop_base::preboot]","recipe[dop_base]"