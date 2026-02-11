#!/bin/bash

# Define the Ollama server host and port
OLLAMA_HOST_PORT="127.0.0.1:11434"
MAX_RETRIES=30
COUNT=0

echo "⏳ Waiting for Ollama service to start on http://$OLLAMA_HOST_PORT..."

# Loop until the API endpoint returns a successful response
until curl -s --max-time 2 http://$OLLAMA_HOST_PORT >/dev/null; do
    COUNT=$((COUNT + 1))
    if [ $COUNT -ge $MAX_RETRIES ]; then
        echo "❌ Error: Ollama service failed to start after $MAX_RETRIES attempts"
        exit 1
    fi
    echo "⏳ Attempt $COUNT of $MAX_RETRIES..."
    sleep 2
done

echo "✅ Ollama service is ready"

