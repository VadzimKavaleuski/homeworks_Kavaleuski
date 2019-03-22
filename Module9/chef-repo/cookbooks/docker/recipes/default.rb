include_recipe "yumupdate"
package "docker" do
action :install
end
service 'docker' do 
action [ :enable, :start ]
end
