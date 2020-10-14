# Responsible for storing Conjur indentity information in the
# Windows Credential Manager.
class conjur::identity::wincred inherits conjur {
  if $conjur::api_key {
    # The Conjur server host name is the target name in Windows
    # Credential Manager.
    credential { regsubst($conjur::client[uri], '.*://([^/]+).*', '\1'):
      ensure   => present,
      username => $conjur::authn_login,
      value    => $conjur::api_key
    }
  }
}
