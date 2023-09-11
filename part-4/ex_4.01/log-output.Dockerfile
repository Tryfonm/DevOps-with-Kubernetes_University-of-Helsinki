FROM python:3.8

WORKDIR /app
RUN apt update -y
RUN apt install -y nano curl iputils-ping
RUN pip install --upgrade pip
RUN pip install Flask requests

ENV PYTHONUNBUFFERED=1
COPY log-output-app.py /app/

ENV PORT 3000
EXPOSE $PORT

CMD ["python", "log-output-app.py"]