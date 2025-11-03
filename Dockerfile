# Base image con R
FROM r-base:latest

# Imposta variabili ambiente per evitare prompt interattivi durante l'installazione
ENV DEBIAN_FRONTEND=noninteractive

# Aggiorna sistema e installa dipendenze di sistema richieste da R packages
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    git \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Installa BiocManager e devtools
RUN R -e "install.packages(c('BiocManager','devtools'), repos='https://cloud.r-project.org')"

# Installa methylKit dalla branch development di GitHub
RUN R -e "devtools::install_github('al2na/methylKit', build_vignettes=FALSE, repos=BiocManager::repositories(), ref='development', dependencies=TRUE)"

# Imposta la directory di lavoro
WORKDIR /home/ruser

# Comando di default per aprire R
CMD ["R"]
