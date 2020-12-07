#!/usr/bin/env ruby

# Takes 2 required command line arguments:
# - policy ID at which to apply policy file (e.g. root)
# - name of policy file to load

# Reads following values from environment variables:
# - CONJUR_AUTHN_LOGIN
# - CONJUR_ADMIN_PASSWORD
# - CONJUR_APPLIANCE_URL
# - CONJUR_CERT_FILE
# - CONJUR_ACCOUNT

# Recommended improvements:
# - check CLI args for count
# - support optional policy method as CLI argument
# - prompt for username & password if not supplied as env vars

require 'conjur-api'

# get command line args
load_at_policy_id = "#{ARGV.first}"
policy_file = "#{ARGV.second}"
policy_method = Conjur::API::POLICY_METHOD_POST

# re: policy_method
#
# The are SIGNIFICANT differences between PUT, POST and PATCH request methods:
#
# - POST implements the default CLI policy load APPEND semantics. It adds data to
#     the existing Conjur policy. Deletions are not allowed. Any policy
#     objects that exist on the server but that are omitted from the policy
#     file will not be deleted, and any explicit deletions in the policy
#     file will result in an error. While not destructive, use of this method
#     can result in a policy file that does not reflect the actual policy
#     in effect.
# - PATCH implements the CLI policy load DELETE flag semantics. It modifies an
#     existing Conjur policy. Data may be explicitly deleted using the
#     !delete, !revoke, and !deny statements. Unlike “replace” mode, no
#     data is ever implicitly deleted. Use of this method makes all policy
#     changes explicit, supporting a kind of audit trail that shows the
#     evolution of the policy.
# - PUT implements the CLI policy load REPLACE flag semantics. Any policy data
#     which already exists on the server at the policy branch but that is not
#     EXPLICITLY specified in the new policy file WILL BE DELETED. It is
#     potentially very destructive and should be used with caution.

# debug output 
#puts "load_at_policy_id: #{load_at_policy_id}"
#puts "policy_file: #{policy_file}"
#puts ""
#puts "CONJUR_AUTHN_LOGIN: #{ENV['CONJUR_AUTHN_LOGIN']}"
#puts "CONJUR_ADMIN_PASSWORD: #{ENV['CONJUR_ADMIN_PASSWORD']}"
#puts "CONJUR_APPLIANCE_URL: #{ENV['CONJUR_APPLIANCE_URL']}"
#puts "CONJUR_CERT_FILE: #{ENV['CONJUR_CERT_FILE']}"
#puts "CONJUR_ACCOUNT: #{ENV['CONJUR_ACCOUNT']}"

username = "#{ENV['CONJUR_AUTHN_LOGIN']}"
password = "#{ENV['CONJUR_ADMIN_PASSWORD']}"

# setup Conjur configuration object
Conjur.configuration.appliance_url = "#{ENV['CONJUR_APPLIANCE_URL']}"
Conjur.configuration.account = "#{ENV['CONJUR_ACCOUNT']}"
Conjur.configuration.cert_file = "#{ENV['CONJUR_CERT_FILE']}"
Conjur.configuration.apply_cert_config!

# Login to Conjur w/ user name/password, authenticate w/ API key & get access token
api_key = Conjur::API.login("#{username}", "#{password}")
conjur = Conjur::API.new_from_key("#{username}", "#{api_key}")
conjur.token

f = File.open("#{policy_file}")
policy_contents = f.read

policy_load_msg = conjur.load_policy("#{load_at_policy_id}", "#{policy_contents}", method: policy_method)
puts "#{policy_load_msg}"
