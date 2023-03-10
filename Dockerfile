FROM jupyter/base-notebook
USER root

WORKDIR app

ENV DEBIAN_FRONTEND noninteractive

# Supporting the options common across Triton stack.

RUN apt-get update \
 && apt-get install -yq --no-install-recommends \
    gcc \
    libc6-dev \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

USER $NB_UID

RUN conda install triton

COPY --chown=${NB_UID}:${NB_GID} notebook /app/$NB_USER/notebook
