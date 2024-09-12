#!/bin/sh

# change to mistral, or any model supported by llama. check https://github.com/ollama/ollama
docker exec -it ollama "ollama run llama3" -d