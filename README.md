# Introduction

This project builds a docker image, placed at `nsfilho/esp8266-rtos-sdk:3.3`.

The goal of this docker image is provide a complete isolated environment for build firmwares, making easy the entire process.

## Example

You can see a sample of use in github actions on [E12AIO3 Firmware](https://github.com/e12aio3)

```yml
name: ESP8266-RTOS-SDK Build

on:
    push:
        branches: [master]

jobs:
    build:
        runs-on: ubuntu-latest
        steps:
            - uses: actions/checkout@v2
            - uses: nsfilho/esp8266-rtos-sdk@v2
```

Thank you and enjoy!
