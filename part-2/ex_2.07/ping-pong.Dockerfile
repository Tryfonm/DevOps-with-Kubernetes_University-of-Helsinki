FROM python:3.8-slim

WORKDIR /app
RUN apt update -y
RUN apt install -y nano curl iputils-ping
RUN pip install --upgrade pip
RUN pip install Flask psycopg2-binary

COPY ping-pong-app.py .
COPY templates/ templates/

ENV PORT 3001
EXPOSE $PORT

CMD ["python", "ping-pong-app.py"]
