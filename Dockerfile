ARG BASE_IMAGE=python:3.10-slim
FROM ${BASE_IMAGE}
LABEL maintainer="Rennan Marujo <rennan.marujo@inpe.br>"

USER root

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update &&\
    apt-get install -y --no-install-recommends \
    build-essential \
    gdal-bin \
    libgdal-dev \
    gcc \
    g++ \
    python3-dev \
    wget \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

ENV CPLUS_INCLUDE_PATH=/usr/include/gdal
ENV C_INCLUDE_PATH=/usr/include/gdal

RUN GDAL_VERSION="$(gdal-config --version)" \
    && pip install --upgrade pip setuptools wheel \
    && pip install "GDAL==${GDAL_VERSION}"

RUN apt-get update && \
    apt-get install -y \
    git \
    curl \
    libproj-dev \
    proj-bin \
    libgeos-dev \
    libsqlite3-dev \
    libspatialite-dev \
    libtiff-dev \
    libjpeg-dev \
    libgeotiff-dev \
    nano \
    unzip

RUN pip install --no-cache-dir \
        scipy \
        scikit-image \
        matplotlib \
        pandas \
    && pip install --no-cache-dir \
        rasterio \
        lxml \
    && pip install --no-cache-dir \
        pyproj \
    && pip install --no-cache-dir \
        geopandas \
    && pip install --no-cache-dir \
        -U scikit-learn \
    && pip install --no-cache-dir \
        -U segmentation-models-pytorch \
    && pip install --no-cache-dir \
        plotly \
        nbformat \
        patchify \
        utm \
        lightgbm \
        click

# FMASK 5
RUN mkdir -p /app
WORKDIR /app
RUN git clone https://github.com/GERSL/Fmask.git
WORKDIR /app/Fmask
ENV FMASK_SCRIPT=/app/Fmask/main/fmask.py

COPY fmask/ /app/Fmask/

ENTRYPOINT ["python", "/app/Fmask/main/fmask.py"]

CMD [ \
  "--imagepath", "/mnt/input", \
  "--model", "UPL", \
  "--dcloud", "0", \
  "--output", "/mnt/output" \
]