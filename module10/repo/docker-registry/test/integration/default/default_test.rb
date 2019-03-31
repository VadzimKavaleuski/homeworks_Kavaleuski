describe docker_container(image: 'registry:2') do
  it { should exist }
  it { should be_running }
end
describe port(5000), :skip do
  it { should be_listening }
end 
