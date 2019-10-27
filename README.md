# C++ API using REST API SDK sample code

Project based on C++ REST SDK sample available at:
https://github.com/ivanmejiarocha/micro-service

## Requirements

Currently, this project only builds on Unix-like OSes. Besides that yout must have installed in your system:
- Docker (ensure that docker-compose is also installed)
- cppchecker
- npm
- Internet connection (you need to download Docker base image)

## Local repository set-up

Here's how you set-up your local repository:

1. Clone this repository into your local workspace:

```
$ git clone git@github.com:yuzu-project/api-holiday.git
$ cd api-holiday
```

2. If you intend to edit this code, you might need to build the C++ REST SDK locally,
so the following must also be installed in the development machine:
- Boost dev libraries 
- OpenSSL dev libraries
- zlib dev libraries

which can be accomplished by running (on Debian-like systems):
```
$ sudo apt-get install sudo apt install libboost-all-dev openssl libzopfli-dev libssl-dev zlib1g-dev
```

3. Run npm script to set-up local development environment:
```
$ npm install
```
If you intend to edit this code, say 'y' (without quotes) when asked to build dependencies.
Otherwise, skip it by answering 'n'.

## Building it


1. Create an environment variable descriptor file by duplicating the supplied example file:

```
$ cp .env.example .env
```

You can edit the `.env` file afterwards to change application default settings.

3. Build and run the application container using the following commmand:

```
$ docker-compose up --build
```

Please note that at the first time the base image will be downloaded and the container image
will be built. This process takes a while. Relax and have a cup of coffee or tea... :)

If you don't want hassle with logs and like the idea to have your terminal clean and not Matrix-like, you can add the `-d` switch to run the container in the backgroung, as in:

```
$ docker-compose up -d --build
```