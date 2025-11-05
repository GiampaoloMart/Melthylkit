FROM rocker/r-base:latest

ENV DEBIAN_FRONTEND=noninteractive

# Installa dipendenze di sistema
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

# Installa BiocManager
RUN R -e "if (!require('BiocManager', quietly = TRUE)) install.packages('BiocManager', repos='https://cloud.r-project.org')"

# Imposta Bioconductor su versione devel
RUN R -e "BiocManager::install(version='devel', ask=FALSE)"

# Installa methylKit
RUN R -e "BiocManager::install('methylKit', ask=FALSE)"

# Directory di lavoro
WORKDIR /data

# Comando di default
CMD ["R"]


