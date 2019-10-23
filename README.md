# C++ API using REST API SDK sample code

Project based on C++ REST SDK sample available at:
https://github.com/ivanmejiarocha/micro-service

## Requirements

Currently, this project only builds on Unix-like OSes. Besides that yout must have installed in your system:
- Docker (ensure that docker-compose is also installed)
- Internet connection (you need to download Docker base image)

## Building it

1. Clone this repository by either downloading it as a zip file or more simply:

$ git clone git@github.com:yuzu-project/api-holiday.git
$ cd api-holiday

2. Create an environment variable descriptor file by duplicating the supplied example file:

$ cp .env.example .env

You can edit the `.env` file afterwards to change application default settings.

3. Build and run the application container using the following commmand:

$ docker-compose up --build

Please note that at the first time the base image will be downloaded and the container image
will be built. This process takes a while. Relax and have a cup of coffee or tea... :/

If you don't want hassle with logs and like the idea to have your terminal clean and not Matrix-like, you can add the `-d` switch to run the container in the backgroung, as in:

$ docker-compose up -d --build