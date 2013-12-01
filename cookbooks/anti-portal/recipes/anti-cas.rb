

service "cassandra" do
  action :stop
end

directory "/var/log/cassandra" do
  recursive true
  action :delete
end

directory "/var/lib/cassandra" do
  recursive true
  action :delete
end

directory "/etc/cassandra" do
  recursive true
  action :delete
end
