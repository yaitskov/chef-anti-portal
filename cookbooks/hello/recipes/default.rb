#
# Cookbook Name:: hello
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


directory "/hello-test" do
  owner     "root"
  group     'root'
  mode      0777
  recursive true
end



