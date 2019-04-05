# See https://docs.getchef.com/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "vadimka"
client_key               "#{current_dir}/vadimka.pem"
chef_server_url          "https://chef/organizations/rd-epam"
cookbook_path            ["#{current_dir}/../cookbooks"]
ssl_verify_mode:verify_none 