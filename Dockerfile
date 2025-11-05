FROM rocker/r-base:latest

ENV DEBIAN_FRONTEND=noninteractive

# Installa dipendenze di sistema per Bioconductor e pacchetti R complessi
RUN apt-get update && apt-get install -y \
    libssl-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    libz-dev \
    libbz2-dev \
    liblzma-dev \
    git \
    r-base-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Installa BiocManager e methylKit (versione devel)
RUN R -e "if (!require('BiocManager', quietly = TRUE)) install.packages('BiocManager', repos='https://cloud.r-project.org')" \
    && R -e "BiocManager::install(version='devel', ask=FALSE)" \
    && R -e \"BiocManager::install('methylKit', ask=FALSE)\"

# Imposta la working directory
WORKDIR /data

# Comando di default: apre R
CMD ["R"]

