# Use Python base image
FROM python:3.11-slim

# Install system dependencies for Playwright
RUN apt-get update && apt-get install -y wget libnss3 libatk1.0-0 libdrm2 libxcomposite1 libxrandr2 libxdamage1 libxkbcommon0 libgbm-dev

# Install Playwright and browser dependencies
RUN pip install --upgrade pip && pip install playwright==1.39.0
RUN playwright install --with-deps

# Copy the script and requirements
WORKDIR /app
COPY . .

# Install Python dependencies
RUN pip install -r requirements.txt

# Command to run the script
CMD ["python", "playwright-login-script.py"]
