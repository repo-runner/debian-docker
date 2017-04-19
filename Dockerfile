FROM debian

ADD https://github.com/Luzifer/repo-runner/releases/download/v0.9.0/inner-runner_linux_amd64 /usr/local/bin/inner-runner

RUN set -ex \
 && apt-get update && apt-get install -y make curl \
 && curl -sSL https://get.docker.com/builds/Linux/x86_64/docker-17.04.0-ce.tgz | tar -xz -C /usr/local/bin --strip-components=1 \
 && chmod +x /usr/local/bin/inner-runner

ENTRYPOINT ["/usr/local/bin/inner-runner"]
