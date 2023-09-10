FROM python:3.8

WORKDIR /app
RUN apt update -y
RUN apt install -y nano curl iputils-ping
RUN pip install --upgrade pip
RUN pip install Flask requests

COPY todo-frontend.py .
COPY templates/ templates/

ENV PYTHONUNBUFFERED=1
ENV PORT 3000
EXPOSE $PORT

CMD ["python", "todo-frontend.py"]