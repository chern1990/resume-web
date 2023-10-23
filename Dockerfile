FROM python:3.10-slim-bullseye
RUN apt-get update -y && apt-get install -y sudo gcc wget gnupg2
# # FOR PYPUPPETEER
# RUN apt install -y gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget

# # FOR PYPUPPETEER
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
RUN sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN sudo apt-get update 
RUN sudo apt-get install -y google-chrome-stable
RUN apt install -y libxss1

WORKDIR /code
COPY . ./

ENV PORT 8000
ENV HOST "0.0.0.0"

EXPOSE ${PORT}:${PORT}

RUN pip install --no-cache-dir --upgrade -r ./requirements.txt
RUN pyppdf-install 

ENV PYTHONUNBUFFERED 1

CMD uvicorn main:app --host=${HOST} --port=${PORT}
