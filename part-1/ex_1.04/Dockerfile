FROM python:3.8-slim

RUN pip install --upgrade pip
RUN pip install Flask

WORKDIR /app
COPY simple-server-app.py .

ENV PORT 3000
EXPOSE $PORT

CMD ["python", "simple-server-app.py"]
