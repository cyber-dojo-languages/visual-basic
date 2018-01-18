FROM  cyberdojofoundation/ubuntu-build-essential:18.04
LABEL maintainer=jon@jaggersoft.com

RUN apt-get update \
 && apt-get install --yes mono-devel \
 && apt-get install --yes mono-vbnc

RUN vbnc -help | grep -q 0.0.0.5943
