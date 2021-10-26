FROM derailed/k9s:latest

# Update packages
RUN apk add --no-cache \
      python3 \
      py3-pip \
      openssl \
      bash \
      curl

# Install aws cli
RUN pip3 install --upgrade pip
RUN pip3 install \
      awscli \
      boto3

# Install kubectl
RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" && \
      chmod +x ./kubectl && \
      mv ./kubectl /usr/local/bin/kubectl

# Install helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
      chmod +x get_helm.sh && \
      ./get_helm.sh

# Clean up
RUN rm -rf /var/cache/apk/*

# Configure image
COPY artefacts/ /
COPY ./entrypoint.py /app/

ENTRYPOINT ["/app/entrypoint.py"]
