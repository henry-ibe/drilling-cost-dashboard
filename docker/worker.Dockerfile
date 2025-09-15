FROM python:3.11-slim
WORKDIR /app
COPY app/worker/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app/worker /app
CMD ["python", "main.py"]
