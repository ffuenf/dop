### Chef Solo
#
#

current_dir = File.dirname(__FILE__)
user_email  = `git config --get user.email`
home_dir    = ENV['HOME']
chef_dir    = "#{current_dir}/.chef"

user        = ( ENV['KNIFE_USER'] || ENV['USER'] || ENV['USERNAME'] ).downcase
orgname     = ENV['KNIFE_ORGNAME']
server_name = ENV['KNIFE_SERVER_NAME']
server_url  = ENV['KNIFE_SERVER_URL']

# user/client and private key to authenticate to a Chef Server, if needed
node_name                 user

if orgname
	# if KNIFE_ORGNAME is given, then we're talking to the Opscode Hosted Chef Server
	validation_client_name  "#{orgname}-validator"
	client_key              "#{chef_dir}/opscode-#{user}.pem"
	validation_key          "#{chef_dir}/opscode-#{orgname}-validator.pem"
	chef_server_url         "https://api.opscode.com/organizations/#{orgname}"
elsif server_name
	# if KNIFE_SERVER_NAME is defined, then we're talking to a Chef Server
	validation_client_name  "chef-validator"
	client_key              "#{chef_dir}/#{server_name}-#{user}.pem"
	validation_key          "#{chef_dir}/#{server_name}-validator.pem"
	chef_server_url         server_url
end

# set default chef environment when bootstrapping
environment               "stable"

# path to cookbooks
cookbook_path [ "#{current_dir}/../cookbooks", "#{current_dir}/../.site-cookbooks" ]

# logging details
log_level                 :info
log_location              STDOUT

# caching options
cache_type                'BasicFile'
cache_options( :path =>   "#{current_dir}/checksums" )

file_backup_path          "#{current_dir}/backups"

# new cookbook defaults
cookbook_copyright        ENV['KNIFE_COOKBOOK_COPYRIGHT'] ||
                          %x{git config --get user.name}.chomp
cookbook_email            ENV['KNIFE_COOKBOOK_EMAIL'] ||
                          %x{git config --get user.email}.chomp
cookbook_license          "apachev2"

encrypted_data_bag_secret 'data_bag_key'
data_bag_path 'data_bags'

knife[:solo_path] = '/tmp/chef-solo'