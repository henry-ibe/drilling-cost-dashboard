FROM python:3.11-slim
WORKDIR /app
COPY app/dash/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app/dash /app
ENV PORT=8501
# API_URL can be overridden via ECS task env if API is on a different host
ENV API_URL=http://localhost:8001
EXPOSE 8501
CMD ["python", "-m", "streamlit", "run", "app.py", "--server.address=0.0.0.0", "--server.port=8501"]
