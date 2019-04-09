describe docker_container(image: 'tc8080') do
    it { should exist }
    it { should be_running }
    not_if "cat docker_state|grep '0.0.0.0:8080->8080/tcp'"
  end
  describe http('http://localhost:8080') do
    its('status') { should cmp 200 }
    not_if "cat docker_state|grep '0.0.0.0:8080->8080/tcp'"
  end  
  describe docker_container(image: 'tc8081') do
    it { should exist }
    it { should be_running }
    only_if "cat docker_state|grep '0.0.0.0:8080->8080/tcp'"
end
describe http('http://localhost:8081') do
  its('status') { should cmp 200 }
  only_if "cat docker_state|grep '0.0.0.0:8080->8080/tcp'"
end  