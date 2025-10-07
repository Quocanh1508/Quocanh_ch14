<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Murach's Java Servlets and JSP</title>
  <link rel="stylesheet" href="styles/main.css" type="text/css"/>
</head>

<body>

<div class="container">
  <h1>Thanks for joining our email list</h1>

  <p>Here is the information that you entered:</p>

  <div class="info-display">
    <p><strong>Email:</strong> <span>${user.email}</span></p>
    <p><strong>First Name:</strong> <span>${user.firstName}</span></p>
    <p><strong>Last Name:</strong> <span>${user.lastName}</span></p>
  </div>

  <p>To enter another email address, click on the Return button shown below.</p>

  <form action="emailList" method="post">
    <input type="hidden" name="action" value="join">
    <input type="submit" value="Return">
  </form>

  <p><i>${errorMessage}</i></p>
</div>

</body>
</html>