# Start from a release LSST stack image.
FROM ghcr.io/lsst/scipipe:al9-w_latest

# Information about image.
ARG BUILD_DATE
LABEL maintainer="https://github.com/jchiang87/agentic_ai_sandbox"
LABEL description="A Docker image for running the Rubin Science Piplines using AI Agents"
LABEL version="latest"
LABEL build_date=$BUILD_DATE

WORKDIR /home/lsst

# Clone this repo.
RUN git clone https://github.com/jchiang87/agentic_ai_sandbox

# Install conda and pip requirements
RUN source /opt/lsst/software/stack/loadLSST.bash &&\
    setup lsst_distrib &&\
    mamba install -y --file agentic_ai_sandbox/etc/conda_requirements.txt
    pip install -r agentic_ai_sandbox/etc/pip_requirements.txt

# Make a script to activate the LSST stack
RUN echo "source /opt/lsst/software/stack/loadLSST.bash" >> .bashrc &&\
    echo "setup lsst_distrib" >> .bashrc
