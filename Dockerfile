# Use an official Python runtime as the base image
FROM python:3.9-slim

# Install wget
RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install the required packages
RUN pip install --no-cache-dir -r requirements.txt

# Download required files
RUN wget https://huggingface.co/datasets/API-Handler/DDC-Free-API/resolve/main/api_handler.py && \
    wget https://huggingface.co/datasets/API-Handler/DDC-Free-API/resolve/main/main.py

# Copy the rest of the application code into the container
COPY . .

# Expose the port that FastAPI will run on
EXPOSE 7860

# Command to run the FastAPI application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "7860"]