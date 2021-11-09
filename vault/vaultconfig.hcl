#General parameters
cluster_name  = "vault-test"
log_level     = "Error"
disable_mlock = "true" #If set to "true" will order Vault to never save secrets to unencrypted swap memory.
ui            = "true"

#Listener
listener "tcp" { #Listener type where only "tcp" is supported.
  address         = "0.0.0.0:8200" #What IP addresses server should be listening on (default port - 8200).
  cluster_address = "X.X.X.X:8201" #What IP address cluster traffic should be using.
  tls_cert_file   = "/etc/vault/certs/vault_cert.crt"
  tls_key_file    = "/etc/vault/certs/vault_cert.key"
  tls_min_version = "tls12"
}

#Storage
storage "mysql" { #Each chosen storage type offers various types of options and parameters.
  address     = "vault-mysql-1.mysql.database.azure.com:3306"
  username    = "foo"
  password    = "bar"
  database    = "db-test"
  tls_ca_file = "/etc/vault/certs/mysql.pem"
  ha_enabled  = "true" #Specific to storage backend. Enables HA.
}

#Monitoring
telemetry { #Unlike above configuration blocks, telemetry target in use is not defined at the beginning of the block. Those settings are actually defined within the block itself upon deciding on telemetry target.
  disable_hostname parameter = false #Defaults to false. Only general parameter that can be set regardless of the target monitoring backend.
  statsd_address             = "0.0.0.0:8125" #Example of target's telemetry aggregator (StatsD) address.
}

seal “azurekeyvault” { #Each chosen auto sealt type offers various options and parameters.
  tenant_id     = ""
  client_id     = ""
  client_secret = ""
  vault_name    = "vault-test"
  key_name      = "key-test"
}

#HA
api_addr     = "https://vault-test.domain.com:8200" #Node-level API address. If performing client redirection, this is the address that standby nodes will redirect the client's request to. Usually points to load balancer in front of cluster.
cluster_addr = "https://X.X.X.X:8021" #Node-level address that the Vault server is going to advertise to other Vault servers in the cluster for cluster-based communication. Usually the same as "cluster_address" parameter.
