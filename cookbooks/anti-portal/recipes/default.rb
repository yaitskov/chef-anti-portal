#
# Cookbook Name:: anit-portal
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node.override.cassandra.seeds = search(:node, 'tags:cassandra-seed').map {|n|n[:ipaddress]}

include_recipe "cassandra::tarball"

service "cassandra" do
  action :start
end

template "/etc/profile.d/cassandra.sh" do
  owner "root"
  group "root"
  mode "0755"
  source "cassandra.sh.erb"
end
