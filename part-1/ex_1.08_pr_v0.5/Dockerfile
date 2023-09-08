FROM python:3.8

WORKDIR /app
RUN pip install --upgrade pip
RUN pip install Flask

COPY simple-server-app.py .
COPY templates/ templates/

ENV PYTHONUNBUFFERED=1
ENV PORT 3000
EXPOSE $PORT

CMD ["python", "simple-server-app.py"]