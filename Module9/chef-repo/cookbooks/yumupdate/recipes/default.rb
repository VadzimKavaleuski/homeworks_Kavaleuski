#
# Cookbook:: yumupdate
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
execute "yum update" do
command "yum update -y"
end