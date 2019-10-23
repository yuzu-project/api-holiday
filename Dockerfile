FROM renatoyamassaki/base:cpprest-alpine
LABEL project-name=cpprest-api \
      version=1.0 \
      year=2019 \
      description="C++ REST API by Yuzu Project" \
      maintainer=renato@yuzu-project.com
ENV PS1="\033[1;36m\$PWD\$\033[0m "

# Prepare general container environment
RUN apk add openssh bash && \
    adduser -D developer && \
    echo -e "Senha123\nSenha123" | passwd developer

# Copy required scripts to build the application
COPY ./build_dependencies.sh /app/build_dependencies.sh

# Setup app directory and build necessary dependencies
WORKDIR /app
RUN mkdir -p ./build/default && \
    chmod +x ./build_dependencies.sh && \
    ./build_dependencies.sh

# Install our application files
COPY ./src /app/src
COPY ./scripts /app/scripts

# Prepare scripts
RUN chmod +x ./scripts/*

