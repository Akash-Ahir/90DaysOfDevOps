const http = require("http");

const PORT = 3000;

const html = `
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>A simple Node.js app showcasing Docker multi-stage builds</title>
  <style>
    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
      font-family: Arial, sans-serif;
    }

    body {
      min-height: 100vh;
      background: linear-gradient(135deg, #0f172a, #1e293b, #0f766e);
      color: white;
      overflow-x: hidden;
      position: relative;
    }

    .blob {
      position: absolute;
      border-radius: 50%;
      filter: blur(60px);
      opacity: 0.45;
      animation: float 8s ease-in-out infinite;
    }

    .blob.one {
      width: 220px;
      height: 220px;
      background: #22d3ee;
      top: 40px;
      left: 50px;
    }

    .blob.two {
      width: 280px;
      height: 280px;
      background: #a855f7;
      bottom: 60px;
      right: 70px;
      animation-delay: 2s;
    }

    .blob.three {
      width: 180px;
      height: 180px;
      background: #f97316;
      top: 50%;
      left: 60%;
      animation-delay: 4s;
    }

    @keyframes float {
      0%, 100% { transform: translateY(0px) translateX(0px); }
      50% { transform: translateY(-20px) translateX(12px); }
    }

    .container {
      max-width: 1100px;
      margin: 0 auto;
      padding: 60px 20px;
      position: relative;
      z-index: 2;
    }

    .hero {
      text-align: center;
      padding: 80px 20px 40px;
    }

    .badge {
      display: inline-block;
      padding: 10px 18px;
      border-radius: 999px;
      background: rgba(255, 255, 255, 0.12);
      border: 1px solid rgba(255, 255, 255, 0.18);
      backdrop-filter: blur(10px);
      font-size: 14px;
      margin-bottom: 22px;
    }

    h1 {
      font-size: 3.2rem;
      line-height: 1.1;
      margin-bottom: 18px;
    }

    .highlight {
      color: #67e8f9;
    }

    .subtitle {
      max-width: 760px;
      margin: 0 auto;
      font-size: 1.1rem;
      line-height: 1.8;
      color: #dbeafe;
    }

    .cta {
      margin-top: 28px;
    }

    .cta a {
      display: inline-block;
      text-decoration: none;
      background: linear-gradient(90deg, #06b6d4, #8b5cf6);
      color: white;
      padding: 14px 26px;
      border-radius: 14px;
      font-weight: bold;
      box-shadow: 0 10px 30px rgba(0,0,0,0.25);
      transition: transform 0.25s ease, box-shadow 0.25s ease;
    }

    .cta a:hover {
      transform: translateY(-3px);
      box-shadow: 0 16px 40px rgba(0,0,0,0.35);
    }

    .grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
      gap: 22px;
      margin-top: 55px;
    }

    .card {
      background: rgba(255, 255, 255, 0.10);
      border: 1px solid rgba(255, 255, 255, 0.16);
      backdrop-filter: blur(14px);
      border-radius: 22px;
      padding: 24px;
      box-shadow: 0 10px 35px rgba(0,0,0,0.20);
    }

    .card h3 {
      font-size: 1.2rem;
      margin-bottom: 12px;
      color: #f8fafc;
    }

    .card p {
      color: #dbeafe;
      line-height: 1.6;
      font-size: 0.98rem;
    }

    .section-title {
      margin-top: 70px;
      margin-bottom: 18px;
      text-align: center;
      font-size: 2rem;
    }

    .feature-box {
      margin-top: 28px;
      background: rgba(255,255,255,0.08);
      border: 1px solid rgba(255,255,255,0.14);
      border-radius: 24px;
      padding: 30px;
      line-height: 1.8;
      color: #e2e8f0;
    }

    .footer {
      text-align: center;
      margin-top: 70px;
      padding-bottom: 20px;
      color: #cbd5e1;
      font-size: 0.95rem;
    }

    @media (max-width: 768px) {
      h1 {
        font-size: 2.2rem;
      }

      .subtitle {
        font-size: 1rem;
      }

      .hero {
        padding-top: 50px;
      }
    }
  </style>
</head>
<body>
  <div class="blob one"></div>
  <div class="blob two"></div>
  <div class="blob three"></div>

  <div class="container">
    <section class="hero">
      <div class="badge"><span style="color:red; font-weight:bold;">v1</span> • <b>Multi-Stage Builds • Docker Hub</b></div>	
      <h1>Build <span class="highlight">Smaller</span>, Ship <span class="highlight">Faster</span>, Deploy <span class="highlight">Smarter</span></h1>
      <p class="subtitle">
        A simple Node.js app that demonstrates Docker multi-stage builds and Docker Hub deployment.
      </p>
      <div class="cta">
        <a href="#">Dockerized with Love 🚀</a>
      </div>
    </section>

    <section class="grid">
      <div class="card">
        <h3>Single-Stage Build</h3>
        <p>Easy to write, but usually bigger because build tools and runtime stay together in one final image.</p>
      </div>
      <div class="card">
        <h3>Multi-Stage Build</h3>
        <p>Separates the build environment from the runtime image so your final container stays cleaner and lighter.</p>
      </div>
      <div class="card">
        <h3>Docker Hub Ready</h3>
        <p>Once tagged properly, this app image can be pushed to Docker Hub and shared anywhere.</p>
      </div>
      <div class="card">
        <h3>Best Practices</h3>
        <p>Use smaller base images, avoid root users, use specific tags, and reduce unnecessary layers.</p>
      </div>
    </section>

    <h2 class="section-title">Why this Matter</h2>
    <div class="feature-box">
      multi-stage builds create smaller and more secure images, which are faster to build, transfer, and deploy. Docker Hub matters because it lets teams store, version, and distribute images consistently across CI/CD pipelines and environments.
    </div>

    <div class="footer">
      Created for your  • Node.js + Docker 
    </div>
  </div>
</body>
</html>
`;

const server = http.createServer((req, res) => {
  res.writeHead(200, { "Content-Type": "text/html" });
  res.end(html);
});

server.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
