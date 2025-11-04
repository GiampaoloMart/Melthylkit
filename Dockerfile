FROM muhengliao/methylkit:latest

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies for RStudio Server
RUN apt-get update && apt-get install -y \
    gdebi-core wget sudo libssl-dev libapparmor1 libedit2 libclang-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Download and install RStudio Server (for Debian 12 base)
RUN wget https://download2.rstudio.org/server/debian12/amd64/rstudio-server-latest-amd64.deb -O /tmp/rstudio-server.deb \
    && gdebi -n /tmp/rstudio-server.deb \
    && rm /tmp/rstudio-server.deb

# Add RStudio Server to PATH
ENV PATH="/usr/lib/rstudio-server/bin:${PATH}"

# Expose RStudio Server port
EXPOSE 8787

CMD ["/bin/bash"]



