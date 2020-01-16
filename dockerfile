FROM node:8-stretch

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y google-chrome-unstable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf \
      --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64.deb
RUN dpkg -i dumb-init_*.deb

ENV WORKER_USER=pptruser
ENV WORKER_DIR=/home/${WORKER_USER}/worker
RUN groupadd -r ${WORKER_USER} \
    && useradd -r -g ${WORKER_USER} -G audio,video ${WORKER_USER} \
    && mkdir -p ${WORKER_DIR}

WORKDIR ${WORKER_DIR}
COPY ./package*.json index.js ./

RUN mkdir -p /home/${WORKER_USER}/Downloads \
    && chown -R ${WORKER_USER}:${WORKER_USER} /home/${WORKER_USER}

USER ${WORKER_USER}

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["node", "./index.js"]
