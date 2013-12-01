override['java']['install_flavor'] = 'oracle'
override['java']['jdk_version'] = '7'
override['java']['oracle']['accept_oracle_download_terms'] = true

override['java']['jdk']['7']['x86_64']['url'] = 'http://download.oracle.com/otn-pub/java/jdk/7u45-b18/jdk-7u45-linux-x64.tar.gz'
override['java']['jdk']['7']['x86_64']['checksum'] = 'f2eae4d81c69dfa79d02466d1cb34db2b628815731ffc36e9b98f96f46f94b1a'



override.cassandra = {
  :cluster_name => 'AntiPortal',
  #:user => 'dan',
  :rpc_address => '0.0.0.0',
  :vnodes => 256,
  :snitch => 'PropertyFileSnitch',
  :snitch_conf => {
    :default => { :dc => 'DC1', :rac => 'r1' }
  }
}

override.tomcat = {
  :base_version => "7",
  #user"] -
  #node["tomcat"]["group"] -
  #node["tomcat"]["home"]
  :loglevel => "debug",
  :java_options => "-Xmx512M -Djava.awt.headless=true"
}

