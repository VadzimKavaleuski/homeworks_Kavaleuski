FROM nginx
RUN echo 'listen 80;\n server_name mainserver;\nupstream mainsteram  { server tc1; server tc2} \nserver { location / { proxy_pass  http://mainsteram; }}'