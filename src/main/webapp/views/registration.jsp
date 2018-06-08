<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec"
           uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">

    <title>Coffee Shop Registration Page</title>
</head>
<body>
<div class="jumbotron">
    <div class="row align-items-center justify-content-center">
        <h1>Register Below</h1>
    </div>
</div>
<div class="row align-items-center justify-content-center">
    ${response}
    <form:form method="POST" modelAttribute="person" action="/user">

        <div class="form-group">
            <label >Enter Password</label>
            <form:password path="password" cssClass="form-control" />
        </div>

        <div class="form-group">
            <label >Email address</label>
            <form:input path="email" cssClass="form-control" />
        </div>
        <div class="form-group">
            <label >First Name</label>
            <form:input path="firstName" cssClass="form-control" />
        </div>
        <div class="form-group">
            <label >Last Name</label>
            <form:input path="lastName" cssClass="form-control" />
        </div>

        <div class="form-group">
            <label >Phone No</label>
            <form:input path="phone" cssClass="form-control" />
        </div>
        <div class="form-group">
            <label >City </label>
            <form:input path="address.city" cssClass="form-control" />
        </div>

        <div class="form-group">
            <label >State</label>
            <form:input path="address.state" cssClass="form-control" />
        </div>
        <div class="form-group">
            <label >Country</label>
            <form:input path="address.country" cssClass="form-control" />
        </div>
        <div class="form-group">
            <label >Zip Code</label>
            <form:input path="address.zipcode" cssClass="form-control" />
        </div>
        <button type="submit" class="btn btn-primary">Submit</button>
    </form:form>
</div>

</body>
</html>