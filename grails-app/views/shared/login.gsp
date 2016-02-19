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

                Log in

            </header>

            <article id="signup_login">

                <g:form class="form" action="loging" name="logingForm">
                    <g:actionSubmit style="height : 68px ;"class="submit" value="log in" action="loging" />
                    
                    <g:textField name="username" style="width : 300px ;" placeholder="Username" />
                    <g:textField name="password" style="width : 300px ;" placeholder="Password" />
                    <g:hiddenField name="remember-me" value="false"/>
                </g:form>

            </article>

        </section>

        <!-- inclusion of the footer -->
        <g:include controller="shared" action="footer"/>

    </body>
</html>