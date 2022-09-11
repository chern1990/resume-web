FROM python:3.9.13

COPY . /src
COPY ./requirements.txt /src/requirements.txt

WORKDIR src

ENV PORT 8000
ENV HOST "0.0.0.0"

EXPOSE 8000:8000

RUN pip install -r requirements.txt

CMD [ "uvicorn", "main:app" ]