# Usa un'immagine base R ufficiale (Debian 12)
FROM rocker/r-base:latest

# Evita richieste interattive
ENV DEBIAN_FRONTEND=noninteractive

# Installa dipendenze di sistema e strumenti essenziali
RUN apt-get update && apt-get install -y \
    wget \
    gdebi-core \
    sudo \
    libssl-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    libapparmor1 \
    libedit2 \
    libclang-dev \
    git \
    r-base-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Installa RStudio Server (ultima versione per Debian 12)
RUN wget https://download2.rstudio.org/server/debian12/amd64/rstudio-server-latest-amd64.deb -O /tmp/rstudio-server.deb \
    && gdebi -n /tmp/rstudio-server.deb \
    && rm /tmp/rstudio-server.deb

# Crea un utente per RStudio Server
RUN useradd -m rstudio && echo "rstudio:rstudio" | chpasswd && adduser rstudio sudo

# Installa devtools, BiocManager e methylKit
RUN R -e "install.packages(c('devtools', 'BiocManager'), repos='https://cloud.r-project.org')" \
    && R -e "devtools::install_github('al2na/methylKit', build_vignettes=FALSE, repos=BiocManager::repositories(), ref='development', dependencies=TRUE)"

# Espone la porta di RStudio Server
EXPOSE 8787

# Comando di default
CMD ["/usr/lib/rstudio-server/bin/rserver", "--server-daemonize=0"]
