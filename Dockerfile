FROM nvidia/cuda:8.0-devel-ubuntu16.04

RUN apt-get update &&\
    apt-get install -y --no-install-recommends \
    git \   
    ca-certificates

WORKDIR /software/

RUN git clone https://github.com/ewanbarr/dedisp.git && \
    cd dedisp &&\
    make -j 32 && \
    make install 

RUN git clone https://github.com/ewanbarr/peasoup.git && \
    cd peasoup && \
    make -j 32 && \
    make install 
   
RUN ldconfig /usr/local/lib


