import os
from flask import Flask, render_template_string
import psycopg
import redis

app = Flask(__name__)

TEMPLATE = """
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Day 34 Compose App</title>
  <style>
    :root {
      --bg: #0f172a;
      --card: #111827;
      --text: #e5e7eb;
      --muted: #94a3b8;
      --border: #334155;
    }

    * {
      box-sizing: border-box;
    }

    body {
      margin: 0;
      font-family: Arial, sans-serif;
      background: linear-gradient(135deg, var(--bg), #020617);
      color: var(--text);
    }

    .container {
      max-width: 900px;
      margin: 0 auto;
      padding: 32px 20px;
    }

    .hero, .card {
      background: rgba(17, 24, 39, 0.92);
      border: 1px solid var(--border);
      border-radius: 16px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.25);
    }

    .hero {
      padding: 28px;
      margin-bottom: 24px;
      text-align: center;
    }

    h1 {
      margin: 0 0 10px;
      font-size: 2rem;
    }

    p {
      color: var(--muted);
      line-height: 1.6;
    }

    .grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
      gap: 18px;
    }

    .card {
      padding: 20px;
      text-align: center;
    }

    .status {
      display: inline-block;
      padding: 8px 12px;
      border-radius: 999px;
      font-size: 0.95rem;
      font-weight: 700;
      margin-bottom: 12px;
    }

    .ok {
      background: rgba(34, 197, 94, 0.15);
      color: #86efac;
    }

    .bad {
      background: rgba(239, 68, 68, 0.15);
      color: #fca5a5;
    }

    .count {
      font-size: 2rem;
      font-weight: bold;
      color: #38bdf8;
      margin-top: 10px;
    }

    .footer {
      margin-top: 22px;
      font-size: 0.95rem;
      text-align: center;
    }

    code {
      background: #1f2937;
      padding: 2px 6px;
      border-radius: 6px;
      color: #38bdf8;
    }
  </style>
</head>
<body>
  <div class="container">
    <section class="hero">
      <h1>Hello from my 3-service Docker Compose app</h1>
      <p>Simple Flask frontend connected to PostgreSQL and Redis.</p>
    </section>

    <section class="grid">
      <article class="card">
        <div class="status {{ 'ok' if db.status == 'connected' else 'bad' }}">
          Database: {{ db.status }}
        </div>
        {% if db.status != 'connected' %}
          <p><strong>Error:</strong> {{ db.error }}</p>
        {% endif %}
      </article>

      <article class="card">
        <div class="status {{ 'ok' if cache.status == 'connected' else 'bad' }}">
          Redis: {{ cache.status }}
        </div>
        {% if cache.status == 'connected' %}
          <div class="count">{{ cache.visits }}</div>
          <p>Total visits</p>
        {% else %}
          <p><strong>Error:</strong> {{ cache.error }}</p>
        {% endif %}
      </article>
    </section>

    <p class="footer">JSON endpoint: <code>/api/status</code></p>
  </div>
</body>
</html>
"""

def check_db():
    try:
        # Read password from Docker secrets file first
        db_password = None
        password_file = '/run/secrets/db_password'
        if os.path.exists(password_file):
            with open(password_file, 'r') as f:
                db_password = f.read().strip()
        
        # Fallback to env if no file (for local dev)
        if not db_password:
            db_password = os.getenv('DB_PASSWORD', '3-service-password')
        
        with psycopg.connect(
            host=os.getenv('DB_HOST', 'db'),
            port=os.getenv('DB_PORT', '5432'),
            dbname=os.getenv('DB_NAME', 'appdb'),
            user=os.getenv('DB_USER', 'appuser'),
            password=db_password
        ) as conn:
            with conn.cursor() as cur:
                cur.execute("SELECT version();")
                version = cur.fetchone()[0]
        return {"status": "connected", "version": version}
    except Exception as exc:
        return {"status": "failed", "error": str(exc)}

def check_cache():
    try:
        client = redis.Redis(
            host=os.getenv('REDIS_HOST', 'cache'),
            port=int(os.getenv('REDIS_PORT', '6379')),
            decode_responses=True
        )
        hits = client.incr("visits")
        return {"status": "connected", "visits": hits}
    except Exception as exc:
        return {"status": "failed", "error": str(exc)}

@app.route("/")
def home():
    db = check_db()
    cache = check_cache()
    return render_template_string(TEMPLATE, db=db, cache=cache)

@app.route("/api/status")
def api_status():
    return {
        "message": "Hello from my 3-service Docker Compose app",
        "database": check_db(),
        "cache": check_cache()
    }

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)



