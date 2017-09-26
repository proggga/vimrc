FROM ubuntu

MAINTAINER Mikhail Fesenko version: 0.0.2

RUN apt-get update

RUN apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev

RUN apt-get install -y curl git

RUN curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash

RUN apt-get install -y software-properties-common

RUN add-apt-repository ppa:jonathonf/vim -y

RUN apt-get update

RUN apt-get install -y vim

ADD .bashrc /root/.bashrc

ENV PATH="/root/.pyenv/bin:${PATH}"

RUN pyenv install 2.7.12

RUN pyenv install 3.6.1

RUN pyenv global 2.7.12
RUN su -l root -c "pip install -U pip"
RUN su -l root -c "pip install pylint flake8"

RUN pyenv global 3.6.1
RUN su -l root -c "pip install -U pip"
RUN su -l root -c "pip install pylint flake8"

RUN git clone  https://github.com/proggga/vimrc.git /root/vimrc

RUN cd /root/vimrc && make generatelinks

RUN apt-get install -y locales

RUN locale-gen ru_RU.UTF-8 && dpkg-reconfigure locales

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
