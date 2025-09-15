import time, os, json, pandas as pd
from datetime import datetime

def run():
    # Minimal stand-in for ingestion/transform
    now = datetime.utcnow().isoformat() + "Z"
    df = pd.DataFrame([{"ts": now, "event": "worker_heartbeat"}])
    out = {"rows": len(df), "preview": df.to_dict(orient="records")}
    print(json.dumps(out))
    # Simulate quick work
    time.sleep(1)

if __name__ == "__main__":
    run()
