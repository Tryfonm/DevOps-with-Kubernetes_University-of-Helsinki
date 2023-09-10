#!/bin/bash

result=$(curl -L -w "%{url_effective}" -o /dev/null -s https://en.wikipedia.org/wiki/Special:Random)
curl -X POST -H "Content-Type: application/json" -d "{\"todo\": \"Read $result\"}" http://todo-backend-svc:2345/todos
