FROM muhengliao/methylkit:latest

ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies (gpg, wget, certificates, etc.)
RUN apt-get update && apt-get install -y \
    wget gdebi-core sudo libssl-dev libapparmor1 libedit2 libclang-dev \
    ca-certificates gnupg2 lsb-release apt-transport-https curl \
    && mkdir -p /usr/share/keyrings \
    && update-ca-certificates

# Add Posit repository key (step-by-step, no pipe)
RUN wget -O /tmp/posit.key https://repo.posit.co/posit.key && \
    gpg --dearmor /tmp/posit.key && \
    mv /tmp/posit.key.gpg /usr/share/keyrings/posit.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/posit.gpg] https://repo.posit.co/deb stable main" > /etc/apt/sources.list.d/posit.list

# Install RStudio Server
RUN apt-get update && apt-get install -y rstudio-server \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Expose RStudio Server port
EXPOSE 8787

# Start RStudio Server automatically
CMD ["/usr/lib/rstudio-server/bin/rserver", "--www-port=8787", "--auth-none=1"]
