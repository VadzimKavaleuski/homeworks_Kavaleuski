include_recipe "docker-registry"
execute "pull nginx" do
  command "docker pull nginx"
  not_if 'docker ps|grep "nginx"'
end
execute "tag nginx" do
  command "docker tag nginx localhost:5000/nginx"
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
#execute "remove local image localhost:5000/nginx" do
#  command "docker rmi localhost:5000/nginx"
#  not_if 'docker ps|grep "localhost:5000/nginx"'
#end
execute "start nginx" do
  command "docker run -d -p 8080:80 localhost:5000/nginx"
  not_if 'docker ps|grep "localhost:5000/nginx"'
end
