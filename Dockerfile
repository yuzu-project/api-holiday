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
COPY ./CMakeLists.txt /app/CMakeLists.txt
COPY ./build_dependencies.sh /app/build_dependencies.sh

# Build necessary dependencies
WORKDIR /app
RUN ./build_dependencies.sh

# Install our application files
COPY ./src /app/src

# Create build support files
RUN mkdir -p ./build/default && \
    cd build/default && \
    cmake -G Ninja ../..

ENTRYPOINT [ "/bin/bash" ]
