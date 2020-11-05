#
# still in development 
#

# ARG centos_version

# FROM centos:${centos_version}
FROM centos

ARG version
ARG build_timestamp

LABEL version=${version}
LABEL build_timestamp=${build_timestamp}
LABEL maintainer="lucas@benning.com.au"

RUN \
        yum -y install python38 git gcc python38-devel bind-utils \
        && git clone https://github.com/aredmond/query-cannon.git \
        && cd query-cannon \
        && python3 -m venv .env \
        && source .env/bin/activate \
        && pip install --upgrade pip \
        && pip install  -e . \ 

COPY --chown=root:root run.sh /

RUN \
	chmod 700 /run.sh


ENTRYPOINT [ "/run.sh" ]