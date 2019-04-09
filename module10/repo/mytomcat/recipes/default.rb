include_recipe "docker"
execute "store docker state" do
  command "docker ps >docker_state"
end
execute "deploy tomcat:8080" do
  command "docker run -d --name tc8080 -p 8080:8080 localhost:5000/#{node.default['tomcatapp']['image']['name']}:#{node.default['tomcatapp']['image']['tag']}"
  not_if "cat docker_state|grep '0.0.0.0:8080->8080/tcp'"
end
execute "undeploy tomcat:8081" do
  command "docker rm -f tc8081"
  only_if "cat docker_state|grep '0.0.0.0:8081->8080/tcp'|grep tc8081&&curl -ILs 'http://localhost:8080' | grep '^HTTP\/1.1 200 OK'"
end
execute "deploy tomcat:8081" do
  command "docker run -d --name tc8081 -p 8081:8080 localhost:5000/#{node.default['tomcatapp']['image']['name']}:#{node.default['tomcatapp']['image']['tag']}"
  only_if "cat docker_state|grep '0.0.0.0:8080->8080/tcp'"
end
execute "undeploy tomcat:8080" do
  command "docker rm -f tc8080"
  only_if "cat docker_state|grep '0.0.0.0:8080->8080/tcp'|grep tc8080&&curl -ILs 'http://localhost:8081' | grep '^HTTP\/1.1 200 OK'"
end