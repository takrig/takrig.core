FROM python:3.9-slim
ARG SOURCE_FOLDER
WORKDIR /src

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt --force

COPY check_application_health.py check_application_health.py
COPY ./src/common ./src/common
COPY ./src/$SOURCE_FOLDER ./src/$SOURCE_FOLDER
COPY ./infrastructure/ ./infrastructure

CMD python -m src.${SOURCE_FOLDER}.main