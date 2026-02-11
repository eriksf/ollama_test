#!/bin/sh

OLLAMA_DIR="$SCRATCH/ollama_test"
OLLAMA_SIF="$OLLAMA_DIR/ollama_0.15.6.sif"
MODEL_PATH="$OLLAMA_DIR/models"
INSTANCE_NAME="ollama-$USER"
PORT=11434

if [[ ! -s "$OLLAMA_SIF" ]]; then
    echo "Pulling ollama image..."
    apptainer pull --dir $OLLAMA_DIR docker://ollama/ollama:0.15.6
fi

echo "Creating model directory, if needed..."
mkdir -p $MODEL_PATH

echo "Starting Ollama instance..."
apptainer instance start \
    --nv \
    --writable-tmpfs \
    "$OLLAMA_SIF" "$INSTANCE_NAME" \
    > $OLLAMA_DIR/$INSTANCE_NAME.log 2>&1

sleep 5

echo "Starting Ollama service..."
#--env OLLAMA_HOST="0.0.0.0:$PORT" \
apptainer exec \
    --env "OLLAMA_MODELS=$MODEL_PATH" \
    instance://$INSTANCE_NAME \
    ollama serve \
    >> $OLLAMA_DIR/$INSTANCE_NAME.log 2>&1 &

sleep 5

echo "To stop ollama, type 'apptainer instance stop $INSTANCE_NAME'" 
