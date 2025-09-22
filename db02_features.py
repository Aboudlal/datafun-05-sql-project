from pathlib import Path
import sqlite3


BASE_DIR = Path(__file__).parent
DB_PATH = BASE_DIR / "project.sqlite3"
FEATURE_DIR = BASE_DIR / "sql_features"


SQL_FILES = [
FEATURE_DIR / "update_records.sql",
FEATURE_DIR / "delete_records.sql",
]


def run_sql_script(conn: sqlite3.Connection, sql_path: Path):
    with open(sql_path, "r", encoding="utf-8") as f:
        sql = f.read()
    conn.executescript(sql)


if __name__ == "__main__":
    with sqlite3.connect(DB_PATH) as conn:
        conn.execute("PRAGMA foreign_keys = ON;")
        for path in SQL_FILES:
            print(f"Running: {path.name}")
            run_sql_script(conn, path)
        conn.commit()
    print("✔ Feature scripts applied.")