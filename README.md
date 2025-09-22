# DataFun-05-SQL — Python + SQLite Project

**Repository:** [https://github.com/Aboudlal/datafun-05-sql-project](https://github.com/Aboudlal/datafun-05-sql-project)

> **Module:** P5 — Python, SQL, and Data at Rest
> **Database:** SQLite (`project.sqlite3`)
> **Schema:** 1→Many (**authors** → **books**)

This project demonstrates how to use **Python** and **SQL (SQLite)** together for basic analytics tasks. You will:

* Build an SQLite database from scratch
* Create a simple **relational schema** with a foreign key
* Insert, update, and delete records with SQL
* Run **queries** (filter, sort, group, aggregate, join)
* Execute SQL from Python scripts (`sqlite3`) and explore results with **pandas**

> **Tip:** If you don’t see new tables/rows in your viewer after running scripts, **refresh or reopen** `project.sqlite3`. Many SQLite viewers cache until refreshed.

---

## Table of Contents

* [Prerequisites](#prerequisites)
* [Project Structure](#project-structure)
* [Quick Start](#quick-start)
* [Schema](#schema)
* [SQL Files](#sql-files)
* [Python Runners](#python-runners)
* [Outputs](#outputs)
* [Git Workflow](#git-workflow)
* [Troubleshooting](#troubleshooting)
* [FAQ: What Runs Where?](#faq-what-runs-where)
* [License](#license)
* [Acknowledgments](#acknowledgments)

---

## Prerequisites

* **Python** ≥ 3.10 (comes with `sqlite3` stdlib)
* **pip** for installing packages
* Recommended: VS Code + *SQLite* extension (to browse the DB)

### Python dependencies

See `requirements.txt`:

```txt
pandas>=2.2.0
python-dateutil>=2.9.0
# sqlite3 is part of Python stdlib – no pip install needed
```

(Optional for charts)

```txt
matplotlib>=3.8.0
```

---

## Project Structure

```
datafun-05-sql-project/
├─ .gitignore
├─ requirements.txt
├─ README.md
├─ project.sqlite3
├─ sql_create/
│  ├─ 01_drop_tables.sql
│  ├─ 02_create_tables.sql
│  └─ 03_insert_records.sql
├─ sql_features/
│  ├─ update_records.sql
│  └─ delete_records.sql
├─ sql_queries/
│  ├─ query_filter.sql
│  ├─ query_sorting.sql
│  ├─ query_group_by.sql
│  ├─ query_aggregation.sql
│  └─ query_join.sql
├─ db01_setup.py
├─ db02_features.py
└─ db03_queries.py
```

---

## Quick Start

### 1) Clone & open

```bash
git clone https://github.com/Aboudlal/datafun-05-sql-project.git
cd datafun-05-sql-project
```

Open the folder in **VS Code**.

### 2) Create & activate a virtual environment

**Windows (PowerShell):**

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
```

**macOS/Linux (bash/zsh):**

```bash
python3 -m venv .venv
source .venv/bin/activate
```

Select the **.venv** interpreter in VS Code.

### 3) Install requirements

```bash
pip install -r requirements.txt
```

### 4) Initialize the database

```bash
python db01_setup.py
```

Expected console output:

```
Running: 01_drop_tables.sql
Running: 02_create_tables.sql
Running: 03_insert_records.sql
✔ Database initialized: project.sqlite3
```

### 5) Apply feature scripts (updates/deletes)

```bash
python db02_features.py
```

### 6) Run analytics queries

```bash
python db03_queries.py
```

This will print query results and save CSV snapshots (`out_*.csv`).

---

## Schema

A simple **1→Many** relationship: one `author` can have many `books`; each `book` belongs to one `author`.

**Tables**

* `authors(author_id TEXT PK, name TEXT NOT NULL, country TEXT)`
* `books(book_id TEXT PK, title TEXT NOT NULL, year_published INTEGER, author_id TEXT NOT NULL FK → authors.author_id)`

**ER (ASCII)**

```
+----------+           1        M           +-------+
| authors  |------------------------------->| books |
+----------+                                +-------+
| author_id (PK)                            | book_id (PK)
| name                                      | title
| country                                   | year_published
                                            | author_id (FK)
```

> IDs are stored as TEXT for readability. For stricter GUIDs, generate UUIDs in Python.

---

## SQL Files

All SQL lives under `sql_create/`, `sql_features/`, and `sql_queries/`.

### Create & seed (`sql_create/`)

* **01\_drop\_tables.sql** — drop in FK-safe order
* **02\_create\_tables.sql** — create `authors` and `books` (with FK)
* **03\_insert\_records.sql** — insert sample authors & books

### Features (`sql_features/`)

* **update\_records.sql** — example updates (e.g., fix title/year)
* **delete\_records.sql** — example delete (remove a book)

### Queries (`sql_queries/`)

* **query\_filter.sql** — `WHERE` filters (e.g., books after 1980)
* **query\_sorting.sql** — `ORDER BY` examples (authors by name)
* **query\_group\_by.sql** — counts per author
* **query\_aggregation.sql** — `COUNT/MIN/MAX/AVG` over books
* **query\_join.sql** — `INNER JOIN` authors ↔ books

> **All statements end with `;`** to avoid `sqlite3.OperationalError: incomplete input`.

---

## Python Runners

The runners open `project.sqlite3`, enable foreign keys, and execute the SQL files.

### `db01_setup.py`

* Drops old tables
* Creates schema
* Inserts seed data

### `db02_features.py`

* Executes updates/deletes from `sql_features/`

### `db03_queries.py`

* Runs each file in `sql_queries/`
* Prints DataFrames
* Saves CSV outputs (`out_*.csv`)

**Important:** All runners use the same path:

```python
from pathlib import Path
BASE_DIR = Path(__file__).parent
DB_PATH = BASE_DIR / "project.sqlite3"
```

Keep the DB name/path consistent across scripts.

---

## Outputs

* Console tables (via pandas) when running `db03_queries.py`
* CSV snapshots in the project root: `out_query_*.csv`
* Browse the database with a VS Code SQLite extension (remember to **refresh** the view)

---

## Git Workflow

### Branching

```bash
git checkout -b feat/p5-sql-initial-setup
```

### Commit (title + body)

```bash
git add .

git commit -m "feat(p5-sql): initial Python + SQLite scaffold" \
  -m "Add SQLite 1:M authors→books schema; SQL (drop/create/insert, update, delete, queries); Python runners (db01/db02/db03); .gitignore, requirements, README."
```

### Push & open PR

```bash
git push -u origin feat/p5-sql-initial-setup
```

Open a Pull Request on GitHub: [https://github.com/Aboudlal/datafun-05-sql-project/compare](https://github.com/Aboudlal/datafun-05-sql-project/compare)

* **Title:** P5: Initial Python + SQLite scaffold (authors/books, queries, runners)
* **Description:** what/why/how + run steps + checklist

### If push is rejected (remote ahead)

```bash
git pull --rebase origin main
# resolve conflicts, then
git push origin feat/p5-sql-initial-setup
```

---

## Troubleshooting

**`sqlite3.OperationalError: incomplete input`**
A statement is unfinished (missing `)`, `;`, or text got truncated). Ensure every SQL block ends with `;` and parentheses close correctly.

**`no such table: books`**

* Run `python db01_setup.py` **before** features/queries.
* Verify both runners point to **the same** `project.sqlite3`.
* Check `02_create_tables.sql` actually creates `books`.

**DB not updating in viewer**

* Close/reopen or **refresh** the SQLite view in VS Code; viewers often cache.

**Wrong interpreter / missing packages**

* In VS Code, pick the **.venv** Python interpreter. Re‑run `pip install -r requirements.txt`.

**Wrong working directory**

* Run commands from the project root so relative paths resolve correctly.

**Database locked**

* Close other tools using the DB (SQLite explorer tabs). Re‑run the script.

---

## FAQ: What Runs Where?

* **SQL** runs **inside a database engine** (SQLite). Execute via `.sql` files from Python or a SQL client. It does **not** run directly in PowerShell/Bash.
* **Python** runs in the **Python interpreter** (scripts or notebooks). From a shell you call `python script.py`.
* **Git** commands run in terminal shells (PowerShell/Bash/zsh).



---

## Acknowledgments

* Course specification: `datafun-05-spec` (project requirements)
* Python `sqlite3`, SQLite, pandas
* VS Code + SQLite extensions
