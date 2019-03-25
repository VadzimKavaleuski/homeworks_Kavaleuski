describe docker.version do
  its('Server.Version') { should cmp >= '1.13'}
  its('Client.Version') { should cmp >= '1.13'}
end