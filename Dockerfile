FROM python:3.9.13

COPY . /src
COPY ./requirements.txt /src/requirements.txt

WORKDIR src

ENV PORT ${PORT}
ENV HOST "0.0.0.0"

EXPOSE ${PORT}:${PORT}

RUN pip install -r requirements.txt

CMD [ "uvicorn", "main:app" ]
