execute "yum update" do
  command "yum update -y&&echo \"#{node['cookbooks']['yumupdate']['version']}\">~/yumupdate"
  not_if "cat ~/yumupdate |grep #{node['cookbooks']['yumupdate']['version']}"
end