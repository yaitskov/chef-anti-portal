


log "current option dd = #{ node.dd }"

ruby_block "bbbb" do
  block do
    puts "log message from ruby block"
    Chef::Log.warn("DDDDDDDDDDDDD")
  end
end
