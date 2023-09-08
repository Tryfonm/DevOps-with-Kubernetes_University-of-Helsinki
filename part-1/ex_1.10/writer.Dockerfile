FROM python:3.8

WORKDIR /app
RUN pip install --upgrade pip

ENV PYTHONUNBUFFERED=1
COPY log-output-writer.py /app/

CMD ["python", "log-output-writer.py"]