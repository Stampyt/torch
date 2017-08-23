FROM ubuntu:16.04

# upgrade the container
RUN apt-get update  && \
    apt-get upgrade -y

# install torch
RUN apt install git -y
RUN git clone https://github.com/torch/distro.git /torch --recursive
WORKDIR /torch
# checkout to the 23/08/2017
RUN git checkout b6ea0652502cda80ccc174c47459ec1b0dc2a9c6
RUN apt-get install -y sudo && rm -rf /var/lib/apt/lists/*
RUN bash install-deps
RUN ./install.sh

# install source and refresh bashrc
#RUN apt install build-essential -y
#RUN source ~/.bashrc

ENV PATH=/torch/install/bin:$PATH

# install torch packages
RUN luarocks install https://raw.githubusercontent.com/benglard/htmlua/master/htmlua-scm-1.rockspec
RUN luarocks install https://raw.githubusercontent.com/benglard/waffle/master/waffle-scm-1.rockspec
