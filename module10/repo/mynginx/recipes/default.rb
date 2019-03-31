load "parametrs.rb"

cookbook_file '/tmp/mynginx.dockerfile' do
  source 'mynginx.dockerfile'
  action :create
end
execute "build mynginx" do
  command "docker image build -f /tmp/mynginx.dockerfile /tmp --tag mynginx:1"
  not_if 'docker images|grep "mynginx"'
end

execute "tag nginx" do
  command "docker tag mynginx localhost:5000/nginx"
  not_if 'docker ps|grep "localhost:5000/nginx"'
end
execute "push nginx to insecue registry" do
  command "docker push localhost:5000/nginx"
  not_if 'docker images|grep "localhost:5000/nginx"'
end
execute "remove local image nginx" do
  command "docker rmi nginx"
  not_if 'docker ps|grep "localhost:5000/nginx"'
end
execute "start nginx" do
  command "docker run -d -p 8080:80 localhost:5000/nginx"
  not_if 'docker ps|grep "localhost:5000/nginx"'
end
