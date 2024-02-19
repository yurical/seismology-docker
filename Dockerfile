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
    dbus \
    pkg-config \
    libxcb*-dev \
    libgl1-mesa-dev \
    libgl1-mesa-glx \
    libxkbcommon-x11-dev \
    libgtk2.0-dev \
    libgtk-3-dev \
    build-essential \
    ccache \
    cmake \
    gnupg \
    gcc-6-base \
    libgfortran3 \
    software-properties-common \
    apt-transport-https \
    curl \
    git \
    geany \
    unzip \
    wget \
    zip \
    libx11-dev \
    python3-tk \
    clang-15 \
    fort77 \
    libkrb5-dev \
    krb5-user \
    liblcms2-2 \
    liblcms2-dev \
 && rm -r /var/lib/apt/lists/*

WORKDIR /work
ENV PATH "/root/.local/bin:${PATH}"
COPY requirements.txt .
RUN pip install --user -r requirements.txt && rm requirements.txt
