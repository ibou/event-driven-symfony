FROM ubuntu:24.04

# ad label
LABEL maintainer="ibou" description="This is custom Docker Image for Python3" version="1.0" 

COPY Makefile /
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
 

# install python
RUN apt-get update
RUN apt-get install -y python3
RUN apt-get install -y python3-pip
# install wget and add user user1
RUN apt-get install -y wget
RUN useradd -ms /bin/bash user1

WORKDIR /home/user1

USER user1
CMD ["Bonjour"]
ENTRYPOINT ["/entrypoint.sh"]