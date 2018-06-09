<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec"
           uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">

    <title>Coffe Shop Home Page</title>
</head>
<body>
<div class="jumbotron">
    <div class="row align-items-center justify-content-center">
        <h1>Login Here</h1>
    </div>
</div>
<div class="row align-items-center justify-content-center">
    <div class="form-group">${response}</div>
</div>

<div class="row align-items-center justify-content-center">
    <form:form method="POST" modelAttribute="person" action="/authenticate">
        <div class="form-group">
            <label>Email address</label>
            <form:input path="email" cssClass="form-control"/>
        </div>
        <div class="form-group">
            <label>Enter Password</label>
            <form:password path="password" cssClass="form-control"/>
        </div>
        <button type="submit" class="btn btn-primary">Submit</button>
    </form:form>


</div>
<p></p>
<div class="row align-items-center justify-content-center">
    <a href="/user"><h4>Sign Up here</h4></a>
</div>
</body>
</html>