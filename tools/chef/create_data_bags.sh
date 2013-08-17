#!/bin/sh

##############
# dop_base
##############
knife solo data bag create users deploy --json-file .data_bags/users_deploy.json
knife solo data bag create users service --json-file .data_bags/users_service.json