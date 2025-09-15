import streamlit as st
import os, requests, pandas as pd

API_URL = os.getenv("API_URL", "http://localhost:8001")

st.set_page_config(page_title="Drilling Cost Dashboard", layout="wide")
st.title("⛽ Drilling Cost Dashboard (MVP)")

col1, col2 = st.columns(2)
with col1:
    st.subheader("Health")
    try:
        ok = requests.get(f"{API_URL}/healthz", timeout=2).json()
        st.success(ok)
    except Exception as e:
        st.error(f"API not reachable at {API_URL}: {e}")

with col2:
    st.subheader("Hello API Demo")
    try:
        r = requests.get(f"{API_URL}/hello", params={"name": "Henry"}, timeout=2).json()
        st.write(r)
    except Exception as e:
        st.error(f"API call failed: {e}")

st.divider()
st.subheader("Sample Costs Table")
df = pd.DataFrame({
    "well": ["A-01", "A-02", "B-01"],
    "rig_days": [12, 15, 11],
    "cost_usd": [240000, 315000, 210000],
})
st.dataframe(df, use_container_width=True)
