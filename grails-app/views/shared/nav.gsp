<!-- NAVIGATION BAR -->

<!doctype html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="/assets/nav.css">
    </head>
    <body>
        <nav>
            <!-- part left for the logo -->
            <div id="left">
                <g:link controller="home" action="index">stacklack</g:link>
                <span class="motto">"${motto}"</span>
            </div>

            <!-- part right for the user view -->
            <div id="right">
                <ul>
                    %{-- disconnected --}%
                    <g:if test="${user != null}">
                        %{-- username + log out + dashboard --}%
                        <li class="text">${user.username}</li>
                        <li><g:link controller="logout">Log out</g:link></li>
                        <li><g:link controller="shared" action="dashboard" id="${user?.id}">Dashboard</g:link></li>
                    </g:if>
                    %{-- disconnected --}%
                    <g:else>
                        %{-- log in + sign up --}%
                        <li><g:link controller="login">Log in</g:link></li>
                        <li><g:link controller="shared" action="signup">Sign up</g:link></li>
                    </g:else>
                </ul>
            </div>
        </nav>
    </body>
</html>