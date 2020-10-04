FROM epiphanyplatform/k8sdeploymentbase:0.0.1

ENV M_WORKDIR "/workdir"
ENV M_RESOURCES "/resources"
ENV M_SHARED "/shared"

COPY resources /resources
COPY workdir /workdir

WORKDIR /workdir

ARG ARG_M_VERSION="unknown"
ENV M_VERSION=$ARG_M_VERSION

ARG ARG_HOST_UID=1000
ARG ARG_HOST_GID=1000
RUN chown -R $ARG_HOST_UID:$ARG_HOST_GID \
    /workdir \
    /resources

USER $ARG_HOST_UID:$ARG_HOST_GID

ENTRYPOINT ["make"]