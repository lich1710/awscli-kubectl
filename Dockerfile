FROM alpine:3.9

ARG AWSCLI_VER=1.16.40
ARG K8S_VER=v1.13.0
ARG HELM_VER=v2.13.1

# Metadata
LABEL author="lich1710@gmail.com" \
      awscli-version=${AWSCLI_VER} \
      kubectl-ver=${K8S_VER}

RUN apk add --no-cache bash ca-certificates jq python py-pip \
    && apk add --no-cache -t deps curl \
    # Install awscli
    \
    && pip install awscli==${AWSCLI_VER} \
    # Install aws-iam-authenticator
    \
    && curl -LO https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/aws-iam-authenticator \
    && chmod +x ./aws-iam-authenticator && mv ./aws-iam-authenticator /usr/local/bin \
    # Install kubectl
    \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/${K8S_VER}/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl && mv ./kubectl /usr/local/bin \
    # Install helm
    \
    && curl -LO https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VER}-linux-amd64.tar.gz \
    && tar xvfz helm-${HELM_VER}-linux-amd64.tar.gz \
    && cp linux-amd64/helm linux-amd64/tiller /usr/local/bin \
    && rm -rf helm-${HELM_VER}-linux-amd64.tar.gz linux-amd64 \
    # Remove dependencies
    \
    && apk del --purge deps

CMD ["aws", "--version"]

