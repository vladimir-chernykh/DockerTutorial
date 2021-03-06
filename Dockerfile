FROM ubuntu:16.04

MAINTAINER Vladimir Chernykh <vladimir.chernykh@phystech.edu>

RUN apt-get update --fix-missing && apt-get install -y \
    git \
    wget \
    bzip2 \
    vim \
    g++

RUN wget --quiet https://repo.continuum.io/archive/Anaconda2-4.2.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh

ENV PATH /opt/conda/bin:$PATH

RUN pip install https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.11.0rc2-cp27-none-linux_x86_64.whl && \
    pip install Keras==1.1.1
    
RUN apt-get install -y graphviz && \
    pip install pydot==1.1.0

RUN pip install cairocffi && \
    apt-get install -y libcairo2 && \
    pip install editdistance

RUN git clone https://github.com/vladimir-chernykh/seq2seq.git /root/seq2seq

RUN python -c "import keras; import json; f = open('/root/.keras/keras.json', 'r'); setting = json.load(f); f.close(); setting['image_dim_ordering'] = 'th'; f = open('/root/.keras/keras.json', 'w'); json.dump(setting, f); f.close()"

RUN mkdir /root/shared

CMD bash -c "jupyter notebook --port=8888 --ip=* --notebook-dir='/root'"
