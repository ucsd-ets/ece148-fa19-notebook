FROM ucsdets/datascience-notebook:2022.3-stable

LABEL maintainer="UC San Diego ITS/ETS <datahub@ucsd.edu>"

USER root

ARG DONKEYCAR_VERSION=4.3.22 DONKEYCAR_BRANCH=main

RUN mkdir /opt/local && \
    cd /opt/local && \
    git clone https://github.com/autorope/donkeycar -b $DONKEYCAR_BRANCH && \
    cd donkeycar && \
    conda env create -f install/envs/ubuntu.yml && \
    eval "$(conda shell.bash hook)" && \
    conda activate donkey && \
    pip install -e .[pc] && \
    conda install -c anaconda --yes --quiet ipykernel && \
    conda install -c anaconda --yes --quiet tensorflow-gpu=2.2.0 && \
#    conda install -c conda-forge --yes --quiet --verbose  cudatoolkit=10.1 && \
    python -m ipykernel install --name=donkeycar --display-name="Donkey Car ($DONKEYCAR_VERSION-$DONKEYCAR_BRANCH)"

USER $NB_UID
