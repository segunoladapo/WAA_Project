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
    <h2>Ordered Product In Cart</h2>

    <table class="table table-striped">
        <thead>
        <tr>
            <th>Product Name</th>
            <th>Description</th>
            <th>Price</th>
            <th>Product Type</th>
            <th>quantity</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="orderline" items="${order.orderLines}">
            <tr>
                <td>${orderline.product.productName}</td>
                <td>${orderline.product.description}</td>
                <td>${orderline.product.price}</td>
                <td>${orderline.product.productType}</td>
                <td>${orderline.quantity}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    Total Quantity: ${quantity}
    <br/>
    Total Price: ${totalAmount}
    <div class="row align-items-center justify-content-center">
        <form:form method="POST" modelAttribute="order" action="/checkout">
            <input type="hidden" value="${token}" name="X-Auth-Token"/>
            <button type="submit" class="btn btn-primary">Checkout</button>
        </form:form>
    </div>
</div>

</body>
</html>