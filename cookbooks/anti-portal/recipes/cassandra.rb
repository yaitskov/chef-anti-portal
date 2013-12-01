#
# Cookbook Name:: anit-portal
# Recipe:: default
#
# cassandra node

node.override.cassandra.seeds = search(:node, 'tags:cassandra-seed').map {|n|n[:ipaddress]}

include_recipe "cassandra::tarball"

template "/etc/profile.d/cassandra.sh" do
  owner "root"
  group "root"
  mode "0755"
  source "cassandra.sh.erb"
end
