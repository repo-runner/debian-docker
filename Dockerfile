FROM debian

ENV REPO_RUNNER_VERSION=v0.11.0 \
    DOCKER_VERSION=17.09.0-ce

ADD https://github.com/Luzifer/repo-runner/releases/download/${REPO_RUNNER_VERSION}/inner-runner_linux_amd64 /usr/local/bin/inner-runner

RUN set -ex \
 && apt-get update && apt-get install -y make curl git \
 && curl -sSL https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz | tar -xz -C /usr/local/bin --strip-components=1 \
 && chmod +x /usr/local/bin/inner-runner

ENTRYPOINT ["/usr/local/bin/inner-runner"]
