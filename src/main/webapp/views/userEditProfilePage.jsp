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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <title>Coffee Shop Registration Page</title>
    <style>
        span {
            color: red; font-weight: bold;

        }
    </style>

</head>
<body>
<div class="jumbotron">
    <div class="row align-items-center justify-content-center">
        <h1>Edit Profile Information</h1>
    </div>
</div>
<div class="row align-items-center justify-content-center">
    ${response}
    <form:form method="PUT" modelAttribute="person" action="/user" onsubmit="return validation()">
        <form:hidden path="id" cssClass="form-control" />
        <form:hidden path="address.id" cssClass="form-control" />
        <div class="form-group">
            <label >Enter Password</label>
            <form:password path="password" id="pword" cssClass="form-control"  />
            <span id="passwordError"></span>
        </div>

        <div class="form-group">
            <label >Email address</label>
            <form:input path="email" id="email" cssClass="form-control" />
            <span id="emailError"></span>
        </div>
        <div class="form-group">
            <label >First Name</label>
            <form:input path="firstName" cssClass="form-control" id="fname" maxlength="25"/>
            <span id="fNameError"></span>
        </div>
        <div class="form-group">
            <label >Last Name</label>
            <form:input path="lastName" cssClass="form-control" id="lname" maxlength="25" />
            <span id="lNameError"></span>
        </div>

        <div class="form-group">
            <label >Phone No</label>
            <form:input path="phone" cssClass="form-control" id="phone" />
            <span id="phoneError"></span>
        </div>
        <div class="form-group">
            <label >City </label>
            <form:input path="address.city" cssClass="form-control" id="city" maxlength="25"/>
            <span id="cityError"></span>
        </div>

        <div class="form-group">
            <label >State</label>
            <form:input path="address.state" cssClass="form-control" id="state" maxlength="25"/>
            <span id="stateError"></span>
        </div>
        <div class="form-group">
            <label >Country</label>
            <form:input path="address.country" cssClass="form-control" id="country" maxlength="25" />
            <span id="countryError"></span>
        </div>
        <div class="form-group">
            <label >Zip Code</label>
            <form:input path="address.zipcode" cssClass="form-control" id="zipCode" />
            <span id="zipCodeError"></span>
        </div>
        <input type="hidden" value="${token}" name="X-Auth-Token"/>
        <button type="submit" class="btn btn-primary">Submit</button>
    </form:form>
</div>

<script type="text/javascript">
    function validation(){
        var error = true;
        var password = document.getElementById("pword").value;
        var email = document.getElementById("email").value;
        var firstName = document.getElementById("fname").value;
        var lastName = document.getElementById("lname").value;
        var Phone = document.getElementById("phone").value;
        var city = document.getElementById("city").value;
        var state = document.getElementById("state").value;
        var country = document.getElementById("country").value;
        var ZipCode = document.getElementById("zipCode").value;

        if(password=='' ){
            document.getElementById("passwordError").innerHTML = "Password Required!";
            error = false;
        }

        if(email==''){
            document.getElementById("emailError").innerHTML = "Email is Required!";
            error = false;
        }
        if(firstName==''){
            document.getElementById("fNameError").innerHTML = "First Name is Required!";
            error = false;
        }
        if(lastName==''){
            document.getElementById("lNameError").innerHTML = "Last Name  is Required!";
            error = false;
        }

        if( Phone==''){
            document.getElementById("phoneError").innerHTML = "Phone Required!";
            error = false;
        }
        if(city==''){
            document.getElementById("cityError").innerHTML = "City is Required!";
            error = false;
        }
        if(state==''){
            document.getElementById("stateError").innerHTML = "State is Required!";
            error = false;
        }
        if(country==''){
            document.getElementById("countryError").innerHTML = "Country  is Required!";
            error = false;
        }
        if(ZipCode==''){
            document.getElementById("zipCodeError").innerHTML = "Zip Code  is Required!";
            error = false;
        }

        if (validateEmail(email)) {

        } else {
            document.getElementById("emailError").innerHTML = "Email is not valid: Format: abc@example.com";
            error = false;
        }

        if (validatePhone(Phone)) {

        } else {
            document.getElementById("phoneError").innerHTML = "Phone is not valid: Format: +XX-XXXX-XXXX";
            error = false;
        }

        if (validateZip(ZipCode)) {

        } else {
            document.getElementById("zipCodeError").innerHTML = "ZipCode is not valid: Format: XXXXX";
            error = false;
        }
        return error;
    }


    function validateEmail(email) {
        var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return re.test(email);
    }

    function validatePhone(phone) {
        var re = /^\+?([0-9]{2})\)?[-. ]?([0-9]{4})[-. ]?([0-9]{4})$/;
        return re.test(phone);
    }

    function validateZip(zipCode) {
        var re = /(^\d{5}$)|(^\d{5}-\d{4}$)/;
        return re.test(zipCode);
    }


</script>

</body>
</html>