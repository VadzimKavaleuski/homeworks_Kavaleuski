include_recipe "docker"

cookbook_file '/tmp/insecure-registry.dockerfile' do
  source 'insecure-registry.dockerfile'
  action :create
end
execute "build registry" do
  command "docker image build -f /tmp/insecure-registry.dockerfile /tmp --tag insecure-registry:1"
  not_if 'docker images|grep "insecure-registry"'
end
execute "start registry" do
  command "docker run -d -p 5000:5000 --name registry insecure-registry:1"
  not_if 'docker ps|grep "insecure-registry:1"'
end
