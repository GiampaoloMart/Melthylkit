# Immagine base ufficiale R (Debian 12)
FROM rocker/r-base:latest

# Evita interazioni durante l’installazione
ENV DEBIAN_FRONTEND=noninteractive

# Installa dipendenze necessarie per methylKit e pacchetti Bioconductor
RUN apt-get update && apt-get install -y \
    libssl-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    git \
    r-base-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Installa devtools e BiocManager
RUN R -e "install.packages(c('devtools', 'BiocManager'), repos='https://cloud.r-project.org')"

# Installa methylKit (versione development da GitHub)
RUN R -e "devtools::install_github('al2na/methylKit', build_vignettes=FALSE, repos=BiocManager::repositories(), ref='development', dependencies=TRUE)"

# Imposta directory di lavoro
WORKDIR /data

# Comando di default: apre la console R
CMD ["R"]

