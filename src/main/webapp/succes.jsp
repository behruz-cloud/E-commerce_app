<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Success Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <style>
        body {
            background-color: #f7f7f7;
        }

        .success-container {
            max-width: 600px;
            margin: auto;
            padding: 40px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.1);
            margin-top: 100px;
        }

        .success-container h1 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 28px;
            color: #343a40;
        }

        .btn-dark {
            width: 100%;
            padding: 12px;
            border-radius: 10px;
        }
    </style>
</head>
<body>

<div class="success-container">
    <div class="card">
        <div class="card-header">
            <h1>Siz muvaffaqiyatli ro'yxatdan o'tdingiz!</h1>
        </div>
        <div class="card-body">
            <p class="text-center">Endi tizimga kirish uchun <a href="/loginPage.jsp">bu yerga</a> bosing.</p>
        </div>
    </div>
</div>

</body>
</html>
