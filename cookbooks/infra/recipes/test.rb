

node.languages.each do |lname,ldesc|
  log "lang #{lname}"
end

log "node ipaddr =   #{node.ipaddress},  name = #{node.name}"
log "node fqdn =   #{node.fqdn}"
log "current option dd = #{ node.dd }"

directory "/tmp/chef-#{Chef::Config[:node_name]}"

Chef::Config.each do |k,v|
  log " configs #{ k } => #{ v }"
end
log "all configs #{Chef::Config}"

ruby_block "bbbb" do
  block do
    puts "log message from ruby block"
    Chef::Log.warn("DDDDDDDDDDDDD")
  end
end
