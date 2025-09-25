<%
    if (session.getAttribute("name") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Logout Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }
        iframe {
            width: 100%;
            height: calc(100vh - 56px); /* full screen minus navbar */
            border: none;
            display: block;
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <span class="navbar-brand">Welcome, <%= session.getAttribute("name") %></span>
            <div class="d-flex">
                <a class="btn btn-danger" href="LogoutServlet">Logout</a>
            </div>
        </div>
    </nav>

    <iframe src="https://j-max-dev.github.io/My-porftfolio/" title="My Portfolio"></iframe>

</body>
</html>