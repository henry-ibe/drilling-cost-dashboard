from fastapi import FastAPI
from pydantic import BaseModel
import os

app = FastAPI(title="DrillCost API", version="0.1.0")

class HelloResp(BaseModel):
    message: str
    region: str | None = None

@app.get("/healthz")
def health():
    return {"ok": True}

@app.get("/hello", response_model=HelloResp)
def hello(name: str = "world"):
    return HelloResp(message=f"hello, {name}", region=os.getenv("AWS_REGION"))
