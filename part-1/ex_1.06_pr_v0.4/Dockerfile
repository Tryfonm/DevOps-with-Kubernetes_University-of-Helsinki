FROM python:3.8-slim

WORKDIR /app
RUN pip install --upgrade pip
RUN pip install Flask

COPY simple-server-app.py .
COPY templates/ templates/

EXPOSE $PORT

CMD ["python", "simple-server-app.py"]
