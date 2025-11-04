FROM muhengliao/methylkit:latest

# Install dependencies for RStudio Server
RUN apt-get update && apt-get install -y \
    gdebi-core wget sudo libssl-dev libapparmor1 libedit2 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Download and install RStudio Server
RUN wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-2025.09.0-421-amd64.deb -O /tmp/rstudio-server.deb \
    && gdebi -n /tmp/rstudio-server.deb \
    && rm /tmp/rstudio-server.deb

# Add RStudio Server to PATH
ENV PATH="/usr/lib/rstudio-server/bin:${PATH}"

CMD ["/bin/bash"]


