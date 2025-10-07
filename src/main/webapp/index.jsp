<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Murach's Java Servlets and JSP</title>
    <link rel="stylesheet" href="styles/main.css" type="text/css"/>
</head>
<body>

<div class="container">

    <!-- ============================================= -->
    <!-- == CHỖ NÀY ĐỂ BẠN CHÈN LOGO. HÃY THAY       == -->
    <!-- == src="images/logo.png" BẰNG ĐƯỜNG DẪN     == -->
    <!-- == ĐÚNG TỚI FILE ẢNH CỦA BẠN.              == -->
    <!-- ============================================= -->
    <img src="images/murachlogo.png" alt="Murach Logo" class="logo">

    <h1>Join our email list</h1>
    <h1>Nguyen Dang Quoc Anh - 23133004</h1>
    <p>To join our email list, enter your name and
        email address below.</p>

    <p><i>${message}</i></p>

    <form action="emailList" method="post">
        <input type="hidden" name="action" value="add">

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" value="${user.email}" required>

        <label for="firstName">First Name:</label>
        <input type="text" id="firstName" name="firstName" value="${user.firstName}" required>

        <label for="lastName">Last Name:</label>
        <input type="text" id="lastName" name="lastName" value="${user.lastName}" required>

        <input type="submit" value="Join Now">
    </form>
</div>

</body>
</html>
