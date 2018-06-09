<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec"
           uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
    <style>
        .error {
            color: red; font-weight: bold;
        }
    </style>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">

    <title>Coffee Shop Registration Page</title>
</head>
<body>
<div class="jumbotron">
    <div class="row align-items-center justify-content-center">
        <h1>Welcome To Coffee Shop</h1>
    </div>
</div>
<div class="row align-items-center justify-content-center">
    ${response}
    <form:form method="POST" modelAttribute="product" action="/saveProduct">

        <div class="form-group">
            <label >Product Name</label>
            <form:input path="productName" cssClass="form-control" />
            <form:errors path="productName" cssClass="error" />
        </div>

        <div class="form-group">
            <label >Product Type</label>
            <form:select path = "productType">
                <form:option value = "NONE" label = "Select"  cssClass="form-control"/>
                <form:options items = "${productTypeList}" />
            </form:select>
        </div>
        <div class="form-group">
            <label >Price</label>
            <form:input path="price" cssClass="form-control" />
        </div>
        <div class="form-group">
            <label >Description</label>
            <form:textarea path="description" cssClass="form-control" />
        </div>
        <input type="hidden" value="${token}" name="X-Auth-Token"/>

        <button type="submit" class="btn btn-primary">Submit</button>
    </form:form>
</div>

</body>
</html>