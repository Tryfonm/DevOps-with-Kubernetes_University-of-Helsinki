FROM alpine:latest

WORKDIR /app
COPY todo-random-wiki.sh .

RUN chmod +x todo-random-wiki.sh
RUN apk --no-cache add curl

CMD ["sh", "todo-random-wiki.sh"]
