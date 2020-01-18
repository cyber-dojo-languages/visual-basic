FROM  cyberdojofoundation/ubuntu-build-essential:18.04
LABEL maintainer=jon@jaggersoft.com

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
 && apt-get install --yes mono-devel \
 && apt-get install --yes mono-vbnc
