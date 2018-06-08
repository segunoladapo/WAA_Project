<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec"
           uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
        <c:if test="${fn:length(order.orderLines) == 0}">
            <p>Your cart is empty <p/>
        </c:if>
        <c:if test="${fn:length(order.orderLines) > 0}">
            <p>You have ${order.orderLines.size()} <p/>
        </c:if>
    </div></div>

<div class="container">
    <h2>Product In Store</h2>

    <table class="table table-striped">
        <thead>
        <tr>
            <th>Product Namr</th>
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