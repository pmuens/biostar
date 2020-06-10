# NOTE: This Dockerfile is based on https://hub.docker.com/r/onlybelter/bio-info

FROM jupyter/scipy-notebook:76402a27fd13

USER root

RUN apt-get update --fix-missing && \
    apt-get install -yq --no-install-recommends wget bzip2 ca-certificates curl \
    unzip ncurses-dev build-essential byacc zlib1g-dev cmake python-dev python-pip \
    libhtml-parser-perl liblist-moreutils-perl libwww-perl default-jdk ant ack-grep \
    liblist-allutils-perl git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER $NB_UID

RUN curl http://data.biostarhandbook.com/install/bash_profile.txt >> ~/.bash_profile && \
    curl http://data.biostarhandbook.com/install/bashrc.txt >> ~/.bashrc && \
    /bin/bash -c "source ~/.bash_profile"

RUN conda update -y -n base conda

RUN conda config --add channels bioconda && \
    conda config --add channels conda-forge && \
    conda config --set show_channel_urls yes && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

RUN curl http://data.biostarhandbook.com/install/conda.txt | xargs conda install -y && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

RUN mkdir -p ~/bin && \
    curl http://data.biostarhandbook.com/install/doctor.py > ~/bin/doctor.py && \
    chmod +x ~/bin/doctor.py

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]
