ARG BASE_IMAGE=python:3.10-slim
FROM ${BASE_IMAGE}
LABEL maintainer="Rennan Marujo <rennan.marujo@inpe.br>"

USER root

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    build-essential \
    gdal-bin \
    libgdal-dev \
    python3-dev \
    wget \
    ca-certificates \
    libproj-dev \
    proj-bin \
    libspatialite-dev \
    libtiff-dev \
    libgeotiff-dev \
    && rm -rf /var/lib/apt/lists/*

ENV CPLUS_INCLUDE_PATH=/usr/include/gdal
ENV C_INCLUDE_PATH=/usr/include/gdal

RUN GDAL_VERSION="$(gdal-config --version)" \
    && pip install --upgrade pip setuptools wheel \
    && pip install "GDAL==${GDAL_VERSION}"

RUN pip install --no-cache-dir \
        scipy \
        scikit-image \
        matplotlib \
        pandas \
        lxml \
        plotly \
        nbformat \
        patchify \
        utm \
        click

RUN pip install --no-cache-dir \
        rasterio \
        pyproj \
        geopandas \
        scikit-learn \
        lightgbm \
        segmentation-models-pytorch

# FMASK 5
WORKDIR /app
RUN git clone https://github.com/GERSL/Fmask.git
WORKDIR /app/Fmask
ENV FMASK_SCRIPT=/app/Fmask/main/fmask.py

COPY fmask/ /app/Fmask/

ENTRYPOINT ["python", "/app/Fmask/main/fmask.py"]