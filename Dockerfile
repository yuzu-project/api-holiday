FROM renatoyamassaki/base:cpprest-alpine
LABEL project-name=cpprest-api \
      version=1.0 \
      year=2019 \
      description="C++ REST API by Yuzu Project" \
      maintainer=renato@yuzu-project.com

RUN apk add openssh bash && \
    adduser -D developer && \
    echo -e "Senha123\nSenha123" | passwd developer

COPY . /app

CMD [ "/bin/bash" ]
