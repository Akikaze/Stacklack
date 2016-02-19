<!DOCTYPE html>
<html>
    <head>
        <title>Welcome to Stacklack</title>
        <link rel="stylesheet" type="text/css" href="/assets/signup_login.css">
    </head>
    <body>

        <!-- inclusion of the navigation bar -->
        <g:include controller="shared" action="nav" id="${user?.id}"/>

        <section>

            <header>

                Sign up

            </header>

            <article id="signup_login">

                <g:form class="form" action="signing" name="signupForm">
                    <g:actionSubmit style="height : 68px ;"class="submit" value="sign up" action="signing" />
                    
                    <g:textField name="username" style="width : 300px ;" placeholder="Username" />
                    <g:textField name="password" style="width : 300px ;" placeholder="Password" />

                </g:form>

            </article>

        </section>

        <!-- inclusion of the footer -->
        <g:include controller="shared" action="footer"/>

    </body>
</html>