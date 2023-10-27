FROM python:3.10-slim-bullseye
RUN apt-get update
RUN apt-get install -y sudo wget vim gcc gnupg

### Debian 11 ###
RUN wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-2/wkhtmltox_0.12.6.1-2.bullseye_amd64.deb
RUN sudo apt install -y -f ./wkhtmltox_0.12.6.1-2.bullseye_amd64.deb

WORKDIR /code
COPY . ./
ENV PORT 8000
ENV HOST "0.0.0.0"
EXPOSE ${PORT}:${PORT}

RUN pip install --no-cache-dir --upgrade -r ./requirements.txt
ENV PYTHONUNBUFFERED 1

CMD uvicorn main:app --host=${HOST} --port=${PORT}


# FROM python:3.10-slim-bullseye
# RUN apt-get update
# RUN apt-get install -y sudo wget gnupg2 gcc

# RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
# RUN echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
# RUN sudo apt update 
# RUN sudo apt install -y google-chrome-stable libxss1

# # RUN apt-get install -y sudo \
# #     gnupg2 \
# #     gcc \
# #     gconf-service \
# #     libasound2 \
# #     libatk1.0-0 \
# #     libatk-bridge2.0-0 \
# #     libc6 \
# #     libcairo2  \
# #     libcups2 \
# #     libdbus-1-3 \
# #     libexpat1 \
# #     libfontconfig1 \
# #     libgcc1 \
# #     libgconf-2-4 \
# #     libgdk-pixbuf2.0-0 \
# #     libglib2.0-0 \
# #     libgtk-3-0 \
# #     libnspr4 \
# #     libpango-1.0-0 \
# #     libpangocairo-1.0-0 \
# #     libstdc++6 \
# #     libx11-6 \
# #     libx11-xcb1 \
# #     libxcb1 \
# #     libxcomposite1 \
# #     libxcursor1 \
# #     libxdamage1 \
# #     libxext6 \
# #     libxfixes3 \
# #     libxi6 \
# #     libxrandr2 \
# #     libxrender1 \
# #     libxss1 \
# #     libxtst6 \
# #     ca-certificates \
# #     fonts-liberation \
# #     libappindicator1 \
# #     libnss3 \
# #     lsb-release \
# #     xdg-utils  \
# #     wget  \
# #     libcairo-gobject2 \
# #     libxinerama1 \
# #     libgtk2.0-0 \
# #     libpangoft2-1.0-0 \
# #     libthai0 \
# #     libpixman-1-0 \
# #     libxcb-render0 \
# #     libharfbuzz0b \
# #     libdatrie1 \
# #     libgraphite2-3 \
# #     libgbm1
# # RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
# # RUN echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/chrome.list

# WORKDIR /code
# COPY . ./

# ENV PORT 8000
# ENV HOST "0.0.0.0"

# EXPOSE ${PORT}:${PORT}

# RUN pip install --no-cache-dir --upgrade -r ./requirements.txt
# # RUN pyppdf-install 
# ENV PYTHONUNBUFFERED 1

# CMD uvicorn main:app --host=${HOST} --port=${PORT}
