ARG SOURCE_DISTRO
ARG SOURCE_TAG

FROM docker.io/${SOURCE_DISTRO}:${SOURCE_TAG}

ARG SOURCE_DISTRO
ARG SOURCE_TAG
ARG BUILD_VERSION

LABEL version="$BUILD_VERSION"
LABEL org.opencontainers.image.title="SNMP Client container"
LABEL org.opencontainers.image.description="SNMP Client running in a container."
LABEL org.opencontainers.image.ref.name="learningtopi/snmp-client"
LABEL org.opencontainers.image.version="$BUILD_VERSION"
LABEL org.opencontainers.image.source="https://github.com/LearningToPi/snmp-client"
LABEL org.opencontainers.image.vendor="LearningToPi.com"
LABEL org.opencontainers.image.base.name="docker.io/$SOURCE_DISTRO:$SOURCE_TAG"
LABEL org.opencontainers.image.documentation="/README.md"

# install snmp client and net-tools
# Added net-tools to use netstat to verify the service is listening for healthchecks
RUN DEBIAN_FRONTEND=noninteractive apt-get update -y &&  \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y snmp libsnmp-base mysql-client && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y net-tools && \
    DEBIAN_FRONTEND=noninteractive apt-get clean -y

# Add README.md
ADD README.md /README.md

ENTRYPOINT ["snmpwalk"]
