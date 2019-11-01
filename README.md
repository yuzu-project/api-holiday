# C++ API using REST API SDK sample code

Project based on C++ REST SDK sample available at:
https://github.com/ivanmejiarocha/micro-service

## Requirements

Currently, this project only builds on Unix-like OSes. Besides that you must have installed in your system:
- Docker (ensure that docker-compose is also installed)
- cppchecker
- clang-format
- npm
- Python 2.7
- Internet connection (you need to download Docker base image)

## Local repository set-up

Here's how you set-up your local repository:

1. Install the above requirements. On Debian-like systems, you can run:
```
$ sudo apt install docker.io cppchecker clang-format npm
```
**Note:** Python 2.7 is already shipped with most recent Linux distributions. If it is not present,
please get Google's help for directions on how to install it.

2. Check that the above requirements was installed successfully by checking 
their versions. You'll get an output similar to:
```
$ docker -v
Docker version 19.03.3, build a872fc2f86
$ cppcheck --version
Cppcheck 1.86
$ clang-format --version
clang-format version 8.0.0-3 (tags/RELEASE_800/final)
$ npm -v
6.9.0
```

3. Check that Docker service is running by issuing the following command:
```
$ sudo docker ps
```
If a connection error occurs, you might need to start and enable Docker service:
```
$ sudo systemctl start docker
$ sudo systemctl enable docker
```

4. If you intend to edit this code, you might need to build the C++ REST SDK locally,
so the following must also be installed in the development machine:
- Boost dev libraries 
- OpenSSL dev libraries
- zlib dev libraries

which can be accomplished by running (on Debian-like systems):
```
$ sudo apt-get install sudo apt install libboost-all-dev openssl libzopfli-dev libssl-dev zlib1g-dev
```

5. Clone this repository into your local workspace:

```
$ git clone git@github.com:yuzu-project/api-holiday.git
$ cd api-holiday
```

6. Run npm script to set-up local development environment:
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

Before you start developing, you must attach git hooks so that static analysis and style-check are done
before every commit.

```
$ npm install
```

## Static analysis and style-checking

Besides the pre-commit hook, you can call the static checker and linter at any time targeting the whole
project. You can call each of them respectivelly by issuing the following commands in the project 
root folder:

```
$ npm run static-analysis
$ npm run lint
```


## Acknowledgements

- Based on [micro service sample code](https://github.com/ivanmejiarocha/micro-service) provided by [ivanmejiarocha](https://github.com/ivanmejiarocha)

- It uses [clang-format script for CI](https://github.com/Sarcasm/run-clang-format) provided by [Sarcasm](https://github.com/Sarcasm).
