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
        <form:form method="PUT" modelAttribute="product" action="/product">
            <input type="hidden" value="${product.id}" name="id"/>
            <div class="form-group">
                <label>Product Type</label>
                <form:select path = "productType" cssClass="form-control">
                    <form:option value = "${product.productType}" label = "${product.productType}"   class="form-control"/>
                    <form:options items = "${productTypeList}" />
                </form:select>
            </div>

            <div class="form-group">
                <label>Name</label>
                <input type="text" value="${product.productName}" name="productName"  class="form-control"/>
            </div>

            <div class="form-group">
                <label>Price</label>
                <input type="text" value="${product.price}" name="price"  class="form-control"/>
            </div>

            <div class="form-group">
                <label>Description</label>
                <textarea name="description" class="form-control">${product.description}</textarea>
            </div>
            <input type="hidden" value="${token}" name="X-Auth-Token"/>

            <button type="submit" class="btn btn-primary">Save Change</button>
        </form:form>
    </div>
</div>
</body>
</html>