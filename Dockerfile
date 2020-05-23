#!/bin/bash
#
# ESP8266-RTOS-SDK-Docker Action
# Copyright (C) 2020 E01-AIO Automação Ltda.
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
# 
# Author: Nelio Santos <nsfilho@icloud.com>
# Repository: https://github.com/nsfilho/ESP8266-RTOS-SDK-Docker
#
FROM debian:buster
LABEL AUTHOR_NAME "Nelio Souza Santos Filho"
LABEL AUTHOR_EMAIL "nsfilho@icloud.com"

# Prepare environment variables
ENV SDK_URL=https://github.com/espressif/ESP8266_RTOS_SDK.git
ENV XTENSA_URL=https://dl.espressif.com/dl/xtensa-lx106-elf-linux64-1.22.0-100-ge567ec7-5.2.0.tar.gz
ENV IDF_PATH=/esp/sdk
ENV PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/esp/sdk/components/esptool_py/esptool:/esp/sdk/components/partition_table:/esp/sdk/tools:/esp/xtensa-lx106-elf/bin

# Generate entrypoint
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]

# Instalando pacotes padrões
RUN apt-get update && apt-get install -y \
    cmake ninja-build git \
    curl wget python-pip \
    libncurses-dev build-essential flex bison gperf \
    gcc make python python-serial && \
    rm -rf /var/lib/apt/lists/*

# Download SDK & Install python requirements
RUN mkdir /esp /esp/sdk && \
    git clone -b release/v3.3 --recursive ${SDK_URL} /esp/sdk && \
    cd /esp/sdk && \
    pip install -r requirements.txt

# Download Toolchain
RUN curl -o /esp/xtensa.tar.gz ${XTENSA_URL} && \
    cd /esp && \
    tar xzvf xtensa.tar.gz && \
    rm -f /esp/xtensa.tar.gz


