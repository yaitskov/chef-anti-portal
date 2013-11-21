

#cookbook_path  "#{ File.dirname(__FILE__) }/cookbooks" 
#environment_path "/var/chef-solo/environments"
environment_path "#{ File.absolute_path(File.dirname(__FILE__)) }/environments"
#chef.environment = 'dev'
file_cache_path "/home/dan/tmp/chef-solo"

#cookbook_path (File.dirname(__FILE__) + "/cookbooks")
cookbook_path "#{ File.absolute_path(File.dirname(__FILE__)) }/cookbooks"


