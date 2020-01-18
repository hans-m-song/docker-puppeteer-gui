FROM node:8-slim

RUN apt-get update -y && apt-get install -y \
    chromium \
    libatk-bridge2.0-0 \
    libgtk-3-0

ARG WORKER_USER=pptruser
ARG WORKER_DIR=/home/${WORKER_USER}/worker
ARG DISPLAY

ENV WORKER_USER=${WORKER_USER}
ENV WORKER_DIR=${WORKER_DIR}
ENV DISPLAY=${DISPLAY}

RUN echo ${WORKER_USER} ${WORKER_DIR}

RUN groupadd -r ${WORKER_USER} \
    && useradd -r -g ${WORKER_USER} -G audio,video ${WORKER_USER} \
    && mkdir -p ${WORKER_DIR} \
    && mkdir -p /home/${WORKER_USER}/Downloads \
    && chown -R ${WORKER_USER}:${WORKER_USER} /home/${WORKER_USER}

WORKDIR ${WORKER_DIR}

COPY --chown=${WORKER_USER} ./package*.json index.js ./

# RUN npm install

USER ${WORKER_USER}

CMD ["node", "./index.js"]
