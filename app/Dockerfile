# Use official Python base image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy app and install dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY app/ .

# Expose port and run app
EXPOSE 5000
CMD ["python", "app.py"]
