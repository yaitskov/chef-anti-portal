override['java']['install_flavor'] = 'oracle'
override['java']['jdk_version'] = '7'
override['java']['oracle']['accept_oracle_download_terms'] = true



override.cassandra = {
  :cluster_name => 'AntiPortal',
  :user => 'dan',
  :rpc_address => '0.0.0.0',
  :vnodes => 256,
  :snitch => 'SimpleSnitch'
}

