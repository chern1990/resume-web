FROM python:3.10-slim-bullseye
RUN apt-get update -y && apt-get install -y gcc

WORKDIR /code
COPY . ./

ENV PORT 8000
ENV HOST "0.0.0.0"

EXPOSE ${PORT}:${PORT}

RUN pip install --no-cache-dir --upgrade -r ./requirements.txt
RUN pyppdf-install 

ENV PYTHONUNBUFFERED 1

CMD uvicorn main:app --host=${HOST} --port=${PORT}
