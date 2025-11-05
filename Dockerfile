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

# Imposta Bioconductor compatibile con R 4.5
RUN R -e "BiocManager::install(version='3.22', ask=FALSE)"

# Installa methylKit da Bioconductor
RUN R -e "BiocManager::install('methylKit', ask=FALSE)"

WORKDIR /data
CMD ["R"]


