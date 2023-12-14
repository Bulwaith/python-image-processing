FROM python:3.11

# 
RUN apt-get update
RUN pip install --upgrade pip

WORKDIR /
ENV PYTHONPATH=/app
# Following will allow to see StdOut logs in K8s (kubectl logs)
ENV PYTHONUNBUFFERED=1

# Copying the app in the Python base image
COPY ./app /app

RUN pip install -r /app/requirements.txt

# Running automated tests to be sure the code works as expected
RUN pytest /app

EXPOSE 8000
# the command to run the application, when the Docker container starts
CMD ["python", "/app/app.py"]