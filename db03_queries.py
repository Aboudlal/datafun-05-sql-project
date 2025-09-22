from pathlib import Path
import sqlite3
import pandas as pd


BASE_DIR = Path(__file__).parent
DB_PATH = BASE_DIR / "project.sqlite3"
QUERY_DIR = BASE_DIR / "sql_queries"


SQL_FILES = [
QUERY_DIR / "query_filter.sql",
QUERY_DIR / "query_sorting.sql",
QUERY_DIR / "query_group_by.sql",
QUERY_DIR / "query_aggregation.sql",
QUERY_DIR / "query_join.sql",
]


def run_query(conn: sqlite3.Connection, sql_text: str) -> pd.DataFrame:
    return pd.read_sql_query(sql_text, conn)


if __name__ == "__main__":
    with sqlite3.connect(DB_PATH) as conn:
        conn.execute("PRAGMA foreign_keys = ON;")
        for path in SQL_FILES:
            print("\n=== RUNNING:", path.name, "===")
            sql_text = path.read_text(encoding="utf-8")
            try:
                df = run_query(conn, sql_text)
                print(df)
                # Optionally save each result to CSV
                out_csv = BASE_DIR / f"out_{path.stem}.csv"
                df.to_csv(out_csv, index=False)
                print("Saved:", out_csv.name)
            except Exception as ex:

                print("(No result set / statement executed)", ex)