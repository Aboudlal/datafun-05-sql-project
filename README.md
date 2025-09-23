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
├─ project_eda.ipynb
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

## License

MIT (or your course default). Add a `LICENSE` file if required.

---

## Acknowledgments

* Course specification: `datafun-05-spec` (project requirements)
* Python `sqlite3`, SQLite, pandas
* VS Code + SQLite extensions

---

## Exploratory Data Analysis (EDA) Notebook

**File:** `project_eda.ipynb` (at the repo root)

This notebook fulfills **Step 3: Plan the Project / Gather Data** with a guided EDA for the 1→Many schema (**authors → books**). It includes:

* Imports and a reliable **DB connection** to `project.sqlite3`
* **Preview** of `authors` and `books` tables
* **Data quality checks** (dtypes, missing values, duplicate PKs)
* **Join** to verify the 1→Many relationship
* **Aggregations** (counts per author, min/max/avg publication year)
* (Optional) a simple chart of books per author

### How to run the notebook

1. Ensure the database exists (run from the repo root):

   ```bash
   python db01_setup.py
   ```
2. Open **`project_eda.ipynb`** in VS Code and select the **.venv** Python kernel.
3. If your notebook is not in the repo root, set the working directory first (Windows example):

   ```python
   import os, pathlib
   os.chdir(r"C:\Repos\datafun-05-sql-project")
   print("CWD:", os.getcwd(), "| DB exists:", pathlib.Path("project.sqlite3").exists())
   ```
4. Run the cells in order. Add a few notes in the final *Findings* cell.

### Troubleshooting (EDA)

* **`no such table: authors`** → Run `db01_setup.py` and/or ensure the notebook points to the correct DB path (see step 3 above).
* **Viewer not updating** → Refresh/close–reopen the SQLite view.
* **Kernel mismatch** → Select the **.venv** interpreter for the notebook.

---

## Step 3 — Plan the Project / Gather Data (EDA)

**Goal.** Complete a guided **Exploratory Data Analysis (EDA)** for the 1→Many schema (**authors → books**) so you understand structure, quality, and relationships before deeper analysis.

**Where.** Use the notebook **[`project_eda.ipynb`](https://github.com/Aboudlal/datafun-05-sql-project/blob/main/project_eda.ipynb)** at the repo root.

**What to include.**

* Imports and a reliable connection to **`project.sqlite3`**
* Preview of `authors` and `books` (head/info)
* Data‑quality checks (dtypes, missing values, duplicate PKs)
* A **JOIN** to verify the 1→Many relationship
* Aggregations (e.g., books per author; min/max/avg publication year)
* 2–4 short **findings** in Markdown; optional simple chart

**How to run.**

1. Build (or rebuild) the DB:

   ```bash
   python db01_setup.py
   ```
2. Open `project_eda.ipynb` in VS Code and select the **.venv** kernel.
3. If the notebook starts in the wrong folder, set the working directory (Windows example):

   ```python
   import os, pathlib
   os.chdir(r"C:\Repos\datafun-05-sql-project")
   print("CWD:", os.getcwd(), "| DB exists:", pathlib.Path("project.sqlite3").exists())
   ```
4. Run cells in order and add your notes in the *Findings* section.

**Custom option.** Instead of authors/books, you may choose **any 1→Many** pair (e.g., directors/movies, teams/players). Keep ≥10 rows per table and update the SQL create/insert scripts before rerunning `db01_setup.py`.

**Recent example update.** Added **Yasmina Khadra — *Ce que le jour doit à la nuit* (2008)**. After applying feature scripts and rerunning the notebook, the time span now covers **1942 → 2008** and the chart includes the new author.

**Troubleshooting (Step 3).**

* `no such table: authors` → run `db01_setup.py` and ensure the notebook points to the correct DB path.
* Viewer not updating → refresh/close–reopen the SQLite view.
* Kernel mismatch → select the **.venv** interpreter for the notebook.
