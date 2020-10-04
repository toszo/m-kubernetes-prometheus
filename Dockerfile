FROM epiphanyplatform/k8sdeploymentbase:0.0.1

ENV M_WORKDIR "/workdir"
ENV M_RESOURCES "/resources"
ENV M_SHARED "/shared"

COPY resources /resources
RUN chmod +x /resources/install.sh

COPY workdir /workdir

WORKDIR /workdir

ARG ARG_M_VERSION="unknown"
ENV M_VERSION=$ARG_M_VERSION

RUN helm repo add prometheus-community https://prometheus-community.github.io/helm-charts &&\
    helm repo add stable https://kubernetes-charts.storage.googleapis.com/ &&\
    helm repo update

#hack - commented due to workaround persmission issue with installing helm packages - TODO uncomment it. 
#ARG ARG_HOST_UID=1000
#ARG ARG_HOST_GID=1000
#RUN chown -R $ARG_HOST_UID:$ARG_HOST_GID \
#    /workdir \
#    /resources 
#
#USER $ARG_HOST_UID:$ARG_HOST_GID

ENTRYPOINT ["make"]