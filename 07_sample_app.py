import streamlit as st
import sqlite3
import pandas as pd

st.set_page_config(page_title="PonyPlanner Dashboard", layout="wide")
st.title("PonyPlanner Dashboard")

db_path = "/Users/ammar/Downloads/ITOM6265_VSCode/sqlite_database.db"

query = """SELECT 
    e.id,
    e.title AS event_name,
    ec.name AS category,
    v.name AS venue,
    e.event_date,
    e.event_time,
    e.capacity,
    u.first_name || ' ' || u.last_name AS organizer
FROM events e
LEFT JOIN event_categories ec ON e.category_id = ec.id
LEFT JOIN venues v ON e.venue_id = v.id
LEFT JOIN users u ON e.organizer_id = u.id
ORDER BY e.event_date, e.event_time;"""

st.sidebar.header("SQL Query")
st.sidebar.code(query, language="sql")

tab1 = st.tabs(["Events Overview"])[0]

with tab1:
    try:
        conn = sqlite3.connect(db_path)
        df = pd.read_sql_query(query, conn)
        conn.close()
        
        st.subheader("PonyPlanner Events")
        st.dataframe(df, use_container_width=True)
        
        st.metric("Total Events", len(df))
        
    except sqlite3.OperationalError as e:
        st.error(f"Database error: {e}")
        st.warning("The required tables may not exist in the database.")
    except Exception as e:
        st.error(f"An error occurred: {e}")
