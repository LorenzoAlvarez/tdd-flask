#pull official base image
FROM python:3.9.0-slim-buster

# set working directory
WORKDIR /usr/src/app

# set envoronment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYHONUNBUFFERED 1

# install system dependencies
RUN apt-get update \
    && apt-get -y install netcat gcc postgresql \
    && apt-get clean

# add and install poetry
RUN pip install poetry
RUN poetry config virtualenvs.create false

# add app
COPY . .

# run server
RUN poetry update
#add entrypoint.sh
COPY ./entrypoint.sh .
RUN chmod +x /usr/src/app/entrypoint.sh