FROM python:3.8

WORKDIR /app
RUN apt update -y
RUN apt install -y nano curl iputils-ping postgresql-client
RUN pip install --upgrade pip
RUN pip install Flask requests psycopg2-binary

COPY todo-backend.py .
COPY check_db_connection.sh .

RUN chmod +x check_db_connection.sh

ENV PYTHONUNBUFFERED=1
ENV PORT 3002
EXPOSE $PORT

CMD ["python", "todo-backend.py"]