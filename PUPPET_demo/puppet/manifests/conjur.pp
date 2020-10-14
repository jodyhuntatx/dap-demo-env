class { conjur:
  account	     => 'dev',
  appliance_url      => 'https://conjur-master-mac:443/api',
  authn_login        => "host/${::trusted['hostname']}",
  host_factory_token => Sensitive('ckbhqq2sgx1zp2yk0vf3q08aebrat3f72fyqhh83perdaq26hnfy9'),
  ssl_certificate    => file('/etc/conjur.pem'),
  version            => 5,
}

