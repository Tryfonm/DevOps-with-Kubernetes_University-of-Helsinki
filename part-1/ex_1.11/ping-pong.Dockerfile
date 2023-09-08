FROM python:3.8-slim

WORKDIR /app
RUN pip install --upgrade pip
RUN pip install Flask

COPY ping-pong-app.py .
COPY templates/ templates/

ENV PORT 3001
EXPOSE $PORT

CMD ["python", "ping-pong-app.py"]
