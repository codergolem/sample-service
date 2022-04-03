FROM python:3.9.12
LABEL maintainer="mario.castellanos@posteo.mx"
LABEL app="ecosia"
LABEL use="Development"

RUN pip install --no-cache-dir pipenv=="2022.3.28"

ENV PROJECT_DIR /app

WORKDIR ${PROJECT_DIR}

COPY  server.py Pipfile Pipfile.lock ${PROJECT_DIR}/
COPY service ${PROJECT_DIR}/service

RUN pipenv install --system --deploy

EXPOSE 80

CMD ["python", "server.py"]