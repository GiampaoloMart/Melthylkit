FROM muhengliao/methylkit:latest

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies and Posit repository key
RUN apt-get update && apt-get install -y \
    wget gdebi-core sudo libssl-dev libapparmor1 libedit2 libclang-dev \
    && wget -qO- https://repo.posit.co/posit.key | gpg --dearmor | tee /usr/share/keyrings/posit.gpg >/dev/null \
    && echo "deb [signed-by=/usr/share/keyrings/posit.gpg] https://repo.posit.co/deb stable main" > /etc/apt/sources.list.d/posit.list \
    && apt-get update && apt-get install -y rstudio-server \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

EXPOSE 8787
CMD ["/bin/bash"]



