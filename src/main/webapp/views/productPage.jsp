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

    <title>Coffee Shop Welcome Page</title>
</head>
<body>
<div class="jumbotron">
    <div class="row align-items-center justify-content-center">
        <h1>Welcome To Coffee Shop</h1>
    </div>
</div>
<div class="container">
    <div class="row align-items-center justify-content-center">
        <form:form method="POST" modelAttribute="product" action="/productAddToCart">
            <div class="form-group">
                <label>Product Type</label>
                <form:textarea path="productType" cssClass="form-control" disabled="true"/>
            </div>
            <div class="form-group">
                <label>Name</label>
                <form:label path="productName" cssClass="form-control"/>
            </div>

            <div class="form-group">
                <label>Price</label>
                <form:label path="price" cssClass="form-control"/>
            </div>

            <div class="form-group">
                <label>Description</label>
                <form:label path="description" cssClass="form-control"/>
            </div>

            <div class="form-group">
                <label>Quantity</label>
                <input type="text" value="" name="quantity" class="form-group" placeholder="Please enter you quantity here"/>
            </div>
            <input type="hidden" value="${token}" name="X-Auth-Token" />
            <form:hidden path="id" />
            <button type="submit" class="btn btn-primary">Add to Cart</button>
        </form:form>
    </div>
</div>
</body>
</html>