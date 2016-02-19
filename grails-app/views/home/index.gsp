<!DOCTYPE html>
<html>
    <head>
        <title>Welcome to Stacklack</title>
        <link rel="stylesheet" type="text/css" href="/assets/index.css">
    </head>
    <body>

        <script>
            /* alert message when you want to answer a question */
            function notLogged()
            {
                alert("You need to be logged to do that!")
            }
        </script>

        <!-- inclusion of the navigation bar -->
        <g:include controller="shared" action="nav" id="${user?.id}"/>

        <section>

            <header>
                %{-- a link for answering or an alert --}%
                <g:if test="${user != null}">
                    <g:link controller="question" action="write" id="${user.id}">Ask question ?</g:link>
                </g:if>
                <g:else>
                    <input type="button" value="Ask question ?" onclick="notLogged();"/>
                </g:else>

            </header>

            <div id="sort">
                <ul>
                    %{-- sort questions --}%
                    <g:if test="${sort == '0'}">
                        <li class="hover">New</li>
                    </g:if>
                    <g:else>
                        <li><g:link controller="home" action="index">New</g:link></li>
                    </g:else>

                    <g:if test="${sort == '1'}">
                        <li class="hover">Not resolved</li>
                    </g:if>
                    <g:else>
                        <li><g:link controller="home" action="index" params="[sort: 1]">Not resolved</g:link></li>
                    </g:else>

                    <g:if test="${sort == '2'}">
                        <li class="hover">Upvoted</li>
                    </g:if>
                    <g:else>
                        <li><g:link controller="home" action="index" params="[sort: 2]">Upvoted</g:link></li>
                    </g:else>
                </ul>
            </div>

            <g:each in="${issues}" var="issue">

                <!-- show of all questions -->
                <article>

                    <g:if test="${issue.resolved == true}">
                        <div id="resolved" style="background-color : #82B21A ;"></div>
                    </g:if>
                    <g:else>
                        <div id="resolved" style="background-color : #242424 ;"></div>
                    </g:else>
                
                    <div id="language">
                        <g:if test="${issue.language == "Javascript"}">
                            <span style="line-height : 32px ;">Java<br/>script</span>
                        </g:if>
                        <g:else>
                            <span style="line-height : 70px ;">${issue.language}</span>
                        </g:else>
                    </div>

                    <div id="title">
                        <h1><g:link controller="question" action="show" id="${issue.id}">${issue.title}</g:link></h1>

                        <g:each in="${issue.tags}" var="tag">
                            <span id="tag">
                                <g:link controller="shared" action="displayTag" id="${tag.id}">
                                    ${tag.text}
                                </g:link>&nbsp;
                            </span>
                        </g:each>

                        <g:if test="${issue.lastUpdated > issue.dateCreated}">
                            modify : <g:formatDate format="dd/MM/yy HH:mm:ss" date="${issue.lastUpdated}"/>
                        </g:if>
                        <g:else>
                            create : <g:formatDate format="dd/MM/yy HH:mm:ss" date="${issue.dateCreated}"/>
                        </g:else>

                        - asked by <g:link controller="shared" action="dashboard" id="${issue.user.id}">${issue.user.username}</g:link>

                    </div>

                    <div id="hide">
                        <span class="block">
                            <div id="vote">
                                ${issue.voteScore}
                                <g:if test="${issue.voteScore >= -1 && issue.voteScore <= 1}">
                                    vote
                                </g:if>
                                <g:else>
                                    votes
                                </g:else>
                            </div>
                            <div id="answer">
                                ${issue.answers.count.size}
                                <g:if test="${issue.answers.count.size <= 1}">
                                    answer
                                </g:if>
                                <g:else>
                                    answers
                                </g:else>
                            </div>
                            <div id="view">
                                ${issue.views}
                                <g:if test="${issue.views <= 1}">
                                    view
                                </g:if>
                                <g:else>
                                    views
                                </g:else>
                            </div>
                        </span>
                    </div>
                    
                </article>
                
            </g:each>
            
        </section>

        <!-- inclusion of the footer -->
        <g:include controller="shared" action="footer"/>

    </body>
</html>