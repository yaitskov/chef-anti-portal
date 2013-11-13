log_level                :info
log_location             STDOUT
node_name                'dan'
client_key               "#{ File.dirname(__FILE__) }/dan.pem"
validation_client_name   'chef-validator'
validation_key           "#{ File.dirname(__FILE__) }/chef-validator.pem"
chef_server_url          'https://chef-server.dan.lan:443'
syntax_check_cache_path  "#{ File.dirname(__FILE__) }/syntax_check_cache"
cookbook_path [ "#{ File.dirname(File.dirname(__FILE__)) }/cookbooks" ]
