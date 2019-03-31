log_level        :info
log_location     "/var/log/chef.log"
chef_server_url  "https://chef/organizations/rd-epam"
validation_client_name "rd-epam-validator"
validation_key "/etc/chef/rd-epam-validator.pem" 
node_name "#{ENV['HOSTNAME']}"
ssl_verify_mode:verify_none 