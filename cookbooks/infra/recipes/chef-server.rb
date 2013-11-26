
# acts in chef-solo

chef_server_deb = "#{Chef::Config[:file_cache_path]}/chef-server_11.0.8-1.ubuntu.12.04_amd64.deb"

remote_file chef_server_deb do
  backup 0
  source "https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chef-server_11.0.8-1.ubuntu.12.04_amd64.deb"
end


dpkg_package "chef_server" do
  source chef_server_deb
  action :install
end


execute "chef-server-ctl reconfigure" 


execute "chef-server-ctl test"
