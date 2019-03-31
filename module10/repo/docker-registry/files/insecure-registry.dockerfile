FROM registry:2
RUN echo '{ "insecure-registries" : ["0.0.0.0":5000" ] }' >/etc/docker/daemon.json