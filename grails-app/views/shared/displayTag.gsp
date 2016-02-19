<!DOCTYPE html>
<html>
    <head>
        <title>Welcome to Stacklack</title>
        <link rel="stylesheet" type="text/css" href="/assets/tag.css">
    </head>
    <body>
    
        <g:include controller="shared" action="nav" id="${user?.id}"/>

        <section>

            <header>
                Tag : <span class="tag">${tag}</span>
            </header>

            <g:each in="${issues}" var="issue">

                <article id="issue">

                    <g:if test="${issue.resolved == true}">
                        <div id="resolved" style="background-color : #82B21A ;"></div>
                    </g:if>
                    <g:else>
                        <div id="resolved" style="background-color : #242424 ;"></div>
                    </g:else>
                
                    <div id="type">
                        Q
                    </div>

                    <div id="title">
                        <h1><g:link controller="issue" action="show" id="${issue.id}">${issue.title}</g:link></h1>
                    </div>

                    <div id="answers">
                        ${issue.answers.count.size}
                        <g:if test="${issue.answers.count.size < 1}">
                            answer
                        </g:if>
                        <g:else>
                            answers
                        </g:else>
                    </div>
                    
                </article>

            </g:each>

        </section>

        <g:include controller="shared" action="footer"/>

    </body>

</html>