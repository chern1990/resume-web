FROM python:3.11
RUN apt-get update
RUN apt-get install -y ca-certificates fonts-liberation libappindicator3-1 libasound2 libatk-bridge2.0-0 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgbm1 libgcc1 libglib2.0-0 libgtk-3-0 libnspr4 libnss3 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 lsb-release wget xdg-utils


WORKDIR /code
COPY . ./
RUN rm -r ./json
ENV PORT 8000
ENV HOST "0.0.0.0"
EXPOSE ${PORT}:${PORT}
RUN pip install --no-cache-dir --upgrade -r ./requirements.txt
RUN pyppdf-install
ENV PYTHONUNBUFFERED 1

CMD uvicorn main:app --host=${HOST} --port=${PORT} --reload
# sudo docker build -t resume-web resume-web
# sudo docker run -dp 0.0.0.0:80:8000 -v /Users/yeecherngoh/Downloads/study/projects/resume-web/json:/json resume-web
