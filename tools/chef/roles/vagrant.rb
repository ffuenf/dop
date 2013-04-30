name "vagrant"
description "vagrant"
run_list "recipe[dop_base::preboot]","recipe[dop_base]"