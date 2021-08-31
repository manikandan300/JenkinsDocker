FROM jenkins/jenkins:lts
 # Switch to root to install .NET Core SDK
USER root


RUN uname -a && cat /etc/*release

# Based on instructiions at https://docs.microsoft.com/en-us/dotnet/core/linux-prerequisites?tabs=netcore2x
# Install depency for dotnet core 2.

RUN	wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb

RUN apt-get update; \
	apt-get install -y apt-transport-https && \
	apt-get update && \
	apt-get install -y dotnet-sdk-5.0

RUN apt-get install -y dotnet-runtime-5.0



RUN	apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
	
RUN curl -fsSL https://download.docker.com/linux/debian/gpg |  gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg	



RUN echo \
	"deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
	$(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt-get -y update	
RUN apt-get -y install  docker-ce-cli


RUN curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

RUN chmod +x /usr/local/bin/docker-compose

RUN cd ~

RUN wget https://deb.nodesource.com/setup_14.x

RUN chmod 777 setup_14.x

RUN ./setup_14.x

RUN apt-get install -y nodejs

USER root