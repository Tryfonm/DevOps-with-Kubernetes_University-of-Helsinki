FROM python:3.8-slim

WORKDIR /app
RUN apt update -y
RUN apt install -y nano curl iputils-ping postgresql-client
RUN pip install --upgrade pip
RUN pip install Flask psycopg2-binary

COPY ping-pong-app.py .
COPY check_db_connection.sh .
COPY templates/ templates/

RUN chmod +x check_db_connection.sh

ENV PORT 3001
EXPOSE $PORT

CMD ["python", "ping-pong-app.py"]
