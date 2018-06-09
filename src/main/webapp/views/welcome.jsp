<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec"
           uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/jquery-1.10.1.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" integrity="sha512-dTfge/zgoMYpP7QbHy4gWMEGsbsdZeCXz7irItjcC3sPUFtf0kuFbDz/ixG7ArTxmDjLXDmezHubeNikyKGVyQ==" crossorigin="anonymous">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>

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
        <div class="row align-items-center justify-content-center">
            <a class="btn btn-primary" href="/userProfile/${product.id}?X-Auth-Token=${token}" role="button">Edit Profile</a>
        </div>
    </div>

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

<security:authorize access="hasAnyRole('ROLE_ADMIN')">
<div class="container">
    <h3>Admin DashBoard</h3>

    <!-- Nav tabs -->
    <ul class="nav nav-tabs" role="tablist">
        <li class="active"><a href="#hometab" role="tab" data-toggle="tab">Product</a></li>
        <li><a href="#javatab" role="tab" data-toggle="tab">View/Create Customer</a></li>
        <li><a href="#csharptab" role="tab" data-toggle="tab">View Orders</a></li>

    </ul>
    </li>

    <!-- Tab panes -->
    <div class="tab-content">
        <div class="tab-pane active" id="hometab">
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
                        <td><a href="productEdit/${product.id}?X-Auth-Token=${token}">Edit</a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <a class="btn btn-primary" href="/product?X-Auth-Token=${token}" role="button">Create New Product</a>

        </div>
        <div class="tab-pane" id="javatab">

            <table class="table table-striped">
                <thead>
                <tr>
                    <th>Email</th>
                    <th>Last Name</th>
                    <th>First Name</th>
                    <th>Phone</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td>${user.email}</td>
                        <td>${user.lastName}</td>
                        <td>${user.firstName}</td>
                        <td>${user.phone}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <a class="btn btn-primary" href="/user" role="button">Create New User</a>
        </div>
        <div class="tab-pane" id="csharptab">
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>Order Date</th>
                    <th>Username</th>
                    <th>No of Order Lines</th>
                    <th>View All Orders</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="order" items="${orders}">
                    <tr>
                        <td>${order.orderDate}</td>
                        <td>${order.person.email}</td>
                        <td>${order.orderLines.size()}</td>
                        <td>


                                <!-- Trigger the modal with a button -->
                                <button type="button" class="btn btn-info btn-primary" data-toggle="modal" data-target="#myModal${order.id}">Details</button>

                                <!-- Modal -->
                                <div class="modal fade" id="myModal${order.id}" role="dialog">
                                    <div class="modal-dialog">

                                        <!-- Modal content-->
                                        <div class="modal-content" style="width:520pt">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                <h4 class="modal-title">Orders</h4>
                                            </div>
                                            <div class="modal-body">
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
                                                Total Quantity: ${order.quantity}
                                                <br/>
                                                Total Price: ${order.totalAmount}
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                            </div>


                                    </div>
                                </div>

                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</security:authorize>
</body>
</html>
