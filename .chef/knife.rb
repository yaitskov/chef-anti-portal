log_level                :info
log_location             STDOUT
node_name                'dan'
client_key               '/home/dan/chef-repo/.chef/dan.pem'
validation_client_name   'chef-validator'
validation_key           '/home/dan/chef-repo/.chef/chef-validator.pem'
chef_server_url          'https://chef-server.dan.lan:443'
syntax_check_cache_path  '/home/dan/chef-repo/.chef/syntax_check_cache'
cookbook_path [ '/home/dan/chef-repo/cookbooks' ]
