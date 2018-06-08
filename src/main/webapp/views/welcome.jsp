<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec"
           uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <style>

    </style>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <title>Coffee Shop Welcome Page</title>
</head>
<body>
<div class="jumbotron">
    <div class="row align-items-center justify-content-center">
        <h1>Welcome To Coffee Shop</h1>
        <p></p>
    </div>
    <div class="row align-items-center justify-content-center">
        <h3>
            <div><p>${response}</p></div>
            <c:if test="${fn:length(order.orderLines) == 0}">
                Your cart is empty
            </c:if>
            <c:if test="${fn:length(order.orderLines) > 0}">
                <div class="container button-wrapper">
                 </div>
            <div class="row align-items-center justify-content-center">
                <a href="/viewCart?X-Auth-Token=${token}" class="btn btn-info btn-lg">
                    <span class="glyphicon glyphicon-shopping-cart">
                    </span>
                  ${order.orderLines.size()} Item(s)</a>
            </c:if>
            </div>
        </h3>
    </div>
</div>

<div class="container">
    <h2>Product In Store</h2>

    <table class="table table-striped">
        <thead>
        <tr>
            <th>Product Name</th>
            <th>Description</th>
            <th>Price</th>
            <th>Product Type</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="product" items="${products}">
            <tr>
                <td>${product.productName}</td>
                <td>${product.description}</td>
                <td>${product.price}</td>
                <td>${product.productType}</td>
                <td><a href="product/${product.id}?X-Auth-Token=${token}">Buy</a></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>