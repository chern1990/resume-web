FROM python:3.10-slim-bullseye
RUN apt-get update -y && apt-get install -y sudo gcc wget gnupg2

# FOR PYPUPPETEER
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
