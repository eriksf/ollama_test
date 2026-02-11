# Ollama test

A simple slurm script to fire up a LLM with Ollama and interact with it.

## Prerequisites

- Git
- Apptainer
- Python >=3.13
- [uv](https://docs.astral.sh/uv/)

  ```console
  > curl -LsSf https://astral.sh/uv/install.sh | sh
  ```

## Installation

```console
> git clone git@github.com:eriksf/ollama_test.git
> cd ollama_test
> uv venv --seed --python 3.13
> uv pip install -r requirements.txt
```

## Usage

1. From a login node, edit the `ollama.slurm` file to add queue, allocation (if needed), and adjust run time.

2. Rename the file `.env.sample` to `.env` and add the API KEY (For local ollama, it's usually "ollama")

3. Submit the job.

  ```console
  $ sbatch ollama.slurm
  ```

4. Output/Error from the Ollama server will be in a file called `ollama-$USER.log` and from the
   scripts will be in `ollama-out.%j` and `ollama-err.%j`, respectively.
