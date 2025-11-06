# Dockerfile
# Use an official lightweight Python image
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file and install dependencies
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code into the container
COPY app/ .

# Expose the port the app runs on
EXPOSE 8080

# Command to run the application
CMD ["python", "app.py"]