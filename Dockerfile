# Base image con R
FROM r-base:latest

ENV DEBIAN_FRONTEND=noninteractive

# Aggiorna e installa librerie di sistema richieste da molti pacchetti bioinformatici
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    git \
    wget \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Installa BiocManager e remotes (più leggero di devtools)
RUN R -e "install.packages(c('BiocManager','remotes'), repos='https://cloud.r-project.org')"

# Installa methylKit dalla branch development di GitHub
RUN R -e "remotes::install_github('al2na/methylKit', build_vignettes=FALSE, repos=BiocManager::repositories(), ref='development', dependencies=TRUE)"

WORKDIR /home/ruser

CMD ["R"]

