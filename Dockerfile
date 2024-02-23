# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: Copyright (C) 2024 Yurical

FROM python:3.10-slim-bookworm

ENV PYTHONUNBUFFERED 1
ENV PIP_NO_CACHE_DIR=1
ENV QT_GRAPHICSSYSTEM="native"
ENV QT_X11_NO_MITSHM=1
ENV LIBGL_ALWAYS_INDIRECT=1

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN echo "deb http://archive.debian.org/debian stretch main" >> /etc/apt/sources.list
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q \
    apt-transport-https \
    build-essential \
    ccache \
    clang-15 \
    cmake \
    curl \
    dbus \
    fort77 \
    gcc-6-base \
    geany \
    git \
    gnupg \
    krb5-user \
    libgfortran3 \
    libgl1-mesa-dev \
    libgl1-mesa-glx \
    libgtk-3-dev \
    libgtk2.0-dev \
    libkrb5-dev \
    liblcms2-2 \
    liblcms2-dev \
    libx11-dev \
    libxcb*-dev \
    libxkbcommon-x11-dev \
    pkg-config \
    python3-tk \
    software-properties-common \
    unzip \
    vim \
    wget \
    zip \
 && rm -r /var/lib/apt/lists/*

WORKDIR /work
ENV PATH "/root/.local/bin:${PATH}"
COPY requirements.txt .
RUN pip install --user -r requirements.txt && rm requirements.txt

# Copy input.tar.gz if exists
COPY input.tar.g[z] .
RUN if [ -f "./input.tar.gz" ]; then tar -xzvf "./input.tar.gz" && rm -f "./input.tar.gz"; fi
