# cassandra cluster can have many instances
# but schema is deployed only once.

remote_file "/home/dan/master.zip" do
  source "https://github.com/yaitskov/anti-portal/archive/master.zip"
  backup 0
end

directory "/home/dan/anti-portal-master" do
  action :delete
  recursive true
end

execute "unzip /home/dan/master.zip -d /home/dan"

execute "/usr/local/cassandra/bin/cqlsh -f /home/dan/anti-portal-master/src/test/resources/schema.cql"

