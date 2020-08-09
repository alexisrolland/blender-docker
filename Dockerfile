FROM ubuntu:bionic

# Set Ubuntu mirror to China
# RUN echo "deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse" > /etc/apt/sources.list
# RUN echo "deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse" >> /etc/apt/sources.list
# RUN echo "deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse" >> /etc/apt/sources.list
# RUN echo "deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse" >> /etc/apt/sources.list
# RUN echo "deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse" >> /etc/apt/sources.list

# Config proxy server
ENV http_proxy=http://proxy.ubisoft.org:3128 https_proxy=http://proxy.ubisoft.org:3128
ENV no_proxy=10.0.0.0/8,192.168.0.0/16,172.16.0.0/12,localhost,127.0.0.1,.ubisoft.org,.ubisoft.onbe,.ubisoft.com

# Install dependencies
RUN apt-get update
RUN apt-get install -y \
    curl \
    libfreetype6 \
    libglu1-mesa \
    libxi6 \
    libxrender1 \
    xz-utils
RUN apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*

# Get Blender arguments
ARG blender_package_name
ARG blender_package_url
ARG blender_path

# Download or copy Blender to temp directory
WORKDIR /tmp
RUN curl -OL $blender_package_url
# COPY ./${blender_package_name}.tar.xz /tmp

# Install Blender and remove archive file
RUN tar -xJf /tmp/${blender_package_name}.tar.xz -C /tmp \
    && rm -f /tmp/${blender_package_name}.tar.xz \
    && mv /tmp/${blender_package_name} ${blender_path}

# Install pip in Blender's Python
ARG blender_python_path
RUN ${blender_python_path}/python3.7m -m ensurepip

# Install custom Python modules in Blender's Python
ARG folder_scripts
RUN mkdir -p ${folder_scripts}
WORKDIR ${folder_scripts}
COPY ./requirements.txt .
RUN ${blender_python_path}/pip3 install --upgrade pip \
    && ${blender_python_path}/pip3 install -r ./requirements.txt