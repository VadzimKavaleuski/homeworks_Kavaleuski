include_recipe "docker"
execute "add composer" do
  command "docker run -d -p 5000:5000 --name registry registry:2"
end
