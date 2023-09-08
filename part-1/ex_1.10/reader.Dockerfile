FROM python:3.8

WORKDIR /app
RUN pip install --upgrade pip
RUN pip install Flask

ENV PYTHONUNBUFFERED=1
COPY log-output-reader.py /app/

ENV PORT 3000
EXPOSE $PORT

CMD ["python", "log-output-reader.py"]