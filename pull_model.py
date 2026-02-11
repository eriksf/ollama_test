from dotenv import load_dotenv
import ollama
import os

# Load environment variables from .env file
load_dotenv()

# Retrieve the variables from the environment
model_name = os.getenv('MODEL_NAME')

print(f"Attempting to pull model: {model_name}")

# The pull function can stream updates
for progress in ollama.pull(model_name, stream=True):
    # This prints the current status, you can process it as needed
    print(f"Status: {progress.get('status')}, Completed: {progress.get('completed')}, Total: {progress.get('total')}")

print(f"Model {model_name} pulled successfully.")

# You can now use the model
#response = ollama.chat(model=model_name, messages=[{'role': 'user', 'content': 'Why is the sky blue?'}])
#print(response['message']['content'])

