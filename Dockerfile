FROM alpine:3.9

ARG AWSCLI_VER=1.16.40
ARG K8S_VER=v1.13.0

# Metadata
LABEL author="lich1710@gmail.com" \
      awscli-version=${AWSCLI_VER} \
      kubectl-ver=${K8S_VER}

RUN apk add --no-cache ca-certificates jq python py-pip \
    && apk add --no-cache -t deps curl \
    && pip install awscli==${AWSCLI_VER} \
    && curl -LO https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/aws-iam-authenticator \
    && chmod +x ./aws-iam-authenticator && mv ./aws-iam-authenticator /usr/local/bin \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/${K8S_VER}/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl && mv ./kubectl /usr/local/bin \
    && apk del --purge deps

CMD ["aws", "--version"]

