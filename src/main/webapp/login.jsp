<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        body {
            margin: 0;
            overflow: hidden;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: black;
            color: #ddd;
        }

        canvas {
            position: fixed;
            top: 0;
            left: 0;
            z-index: 0;
        }

        .wrap {
            position: relative;
            z-index: 2;
            width: 100%;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .card {
            width: 400px;
            padding: 40px;
            border-radius: 10px;
            background: rgba(20, 20, 20, 0.9);
            text-align: center;
        }

        .card h2 {
            margin-bottom: 25px;
            font-size: 26px;
            color: #f1f1f1;
        }

        .card input {
            width: 90%;
            margin: 12px 0;
            padding: 12px;
            border-radius: 6px;
            border: 1px solid #444;
            outline: none;
            background: #111;
            color: #eee;
            font-size: 15px;
        }

        .card button {
            width: 95%;
            margin-top: 20px;
            padding: 12px;
            font-size: 16px;
            font-weight: bold;
            color: #fff;
            background: #333;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.2s;
        }

        .card button:hover {
            background: #555;
        }

        .card a {
            display: block;
            margin-top: 15px;
            color: #aaa;
            text-decoration: none;
            font-size: 14px;
        }

        .card a:hover {
            color: #fff;
        }

        /* SweetAlert2 dark theme */
        .swal2-popup {
            background: #111 !important;
            color: #eee !important;
            border: 1px solid #444 !important;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .swal2-title {
            color: #f1f1f1 !important;
        }
        .swal2-content {
            color: #ccc !important;
        }
        .swal2-confirm {
            background-color: #333 !important;
            color: #fff !important;
        }
        .swal2-confirm:hover {
            background-color: #555 !important;
        }
    </style>
</head>
<body>
    <!-- Background Canvas -->
    <canvas id="matrix"></canvas>

    <!-- Login Card -->
    <div class="wrap">
        <div class="card">
            <h2>User Login</h2>
            <form action="loginServlet" method="post">
                <input type="text" name="username" placeholder="Username" required>
                <input type="password" name="password" placeholder="Password" required>
                <button type="submit">Login</button>
            </form>
            <a href="registration.jsp">Don't have an account? Register →</a>
        </div>
    </div>

    <!-- Hidden status input (set by Servlet) -->
    <input type="hidden" id="status" value="<%= request.getAttribute("status") != null ? request.getAttribute("status") : "" %>">

    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        const status = document.getElementById("status").value;
        if(status === "success") {
            Swal.fire({
                title: 'Login Successful!',
                text: 'Welcome back!',
                icon: 'success',
                confirmButtonText: 'OK'
            });
        } else if(status === "failed") {
            Swal.fire({
                title: 'Login Failed!',
                text: 'Invalid credentials. Please try again.',
                icon: 'error',
                confirmButtonText: 'Retry'
            });
        }
    </script>

    <script>
        const canvas = document.getElementById("matrix");
        const ctx = canvas.getContext("2d");

        canvas.height = window.innerHeight;
        canvas.width = window.innerWidth;

        const binary = "01";
        const fontSize = 16;
        const columns = canvas.width / fontSize;
        const drops = [];

        for (let x = 0; x < columns; x++) drops[x] = 1;

        function draw() {
            ctx.fillStyle = "rgba(0, 0, 0, 0.1)";
            ctx.fillRect(0, 0, canvas.width, canvas.height);

            ctx.fillStyle = "#aaa";
            ctx.font = fontSize + "px monospace";

            for (let i = 0; i < drops.length; i++) {
                const text = binary[Math.floor(Math.random() * binary.length)];
                ctx.fillText(text, i * fontSize, drops[i] * fontSize);

                if (drops[i] * fontSize > canvas.height && Math.random() > 0.975)
                    drops[i] = 0;

                drops[i]++;
            }

            // subtle particles
            for (let i = 0; i < 20; i++) {
                const x = Math.random() * canvas.width;
                const y = Math.random() * canvas.height;
                ctx.beginPath();
                ctx.arc(x, y, 1.2, 0, Math.PI * 2, false);
                ctx.fillStyle = "rgba(200,200,200,0.5)";
                ctx.fill();
            }
        }

        setInterval(draw, 33);

        window.addEventListener("resize", () => {
            canvas.height = window.innerHeight;
            canvas.width = window.innerWidth;
        });
    </script>
</body>
</html>
