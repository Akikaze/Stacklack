<!DOCTYPE html>
<html>
    <head>
        <title>Welcome to Stacklack</title>
        <link rel="stylesheet" type="text/css" href="/assets/dashboard.css">
    </head>
    <body>

        <script>
            /* allow to display comment textarea for connected users */
            function display_modify()
            {                
                if (document.getElementById('modify_hidden_').style.display != 'block')
                {
                    document.getElementById('modify_shown_').style.display = 'none';
                    document.getElementById('modify_hidden_').style.display = 'block';
                }
            }
        </script>
    
        <g:include controller="shared" action="nav" id="${user?.id}"/>

        <section>

            <header>
                Profile : ${user.username}
            </header>

            <article id="info">

                <span id="modify_shown_">
                    <span class="quote">“ </span>${user.profile}<span class="quote"> ”</span>
                    
                    <g:if test="${dashboard == true}">
                        <br/><br/>
                        <input type="button" value="modify your profile" onclick="display_modify();"/>
                    </g:if>
                </span>
                <span id="modify_hidden_" style="display : none ;">
                    <g:form action="modify" name="modifyForm">
                        <g:textArea name="profile" style="min-height : 75px ; resize : vertical ; width : 640px ;" value="${user.profile}" />
                        <g:hiddenField name="user.id" value="${user.id}"/>
                        <g:actionSubmitImage class="input" value="modify" action="modify" src="${resource(dir: 'img', file: 'stacklack/check.png')}" />
                    </g:form>
                </span>

            </article>

        </section>


        <g:if test="${user.reputation != 0}">
            <section><header style="text-align : center ;">
            ${user.reputation} points of reputation
            </header></section>
        </g:if>
        

        <section>

            <header>

                ${posts.count.size}
                <g:if test="${posts.count.size < 1}">
                    post
                </g:if>
                <g:else>
                    posts
                </g:else>

            </header>

            <g:each in="${posts}" var="post">

                <article id="post">

                    <g:if test="${ post instanceof stacklack.Issue }">

                        <g:if test="${post.resolved == true}">
                            <div id="resolved" style="background-color : #82B21A ;"></div>
                        </g:if>
                        <g:else>
                            <div id="resolved" style="background-color : #242424 ;"></div>
                        </g:else>
                    
                        <div id="type">
                            Q
                        </div>

                        <div id="title">
                            <h1><g:link controller="question" action="show" id="${post.id}">${post.title}</g:link></h1>
                        </div>

                        <div id="answers">
                            ${post.answers.count.size}
                            <g:if test="${post.answers.count.size < 1}">
                                answer
                            </g:if>
                            <g:else>
                                answers
                            </g:else>
                        </div>

                    </g:if>

                    <g:if test="${ post instanceof stacklack.Answer }">

                        <g:if test="${post.helped == true}">
                            <div id="resolved" style="background-color : #82B21A ;"></div>
                        </g:if>
                        <g:else>
                            <div id="resolved" style="background-color : #242424 ;"></div>
                        </g:else>
                    
                        <div id="type">
                            A
                        </div>

                        <div id="title">
                            <h1><g:link controller="question" action="show" id="${post.issue.id}">${post.issue.title}</g:link></h1>
                        </div>

                        <div id="answers">
                            ${post.issue.answers.count.size}
                            <g:if test="${post.issue.answers.count.size < 1}">
                                answer
                            </g:if>
                            <g:else>
                                answers
                            </g:else>
                        </div>
                        
                    </g:if>

                </article>

            </g:each>

        </section>

        <section>

            <header>

                ${votes.count.size}
                <g:if test="${votes.count.size < 1}">
                    vote
                </g:if>
                <g:else>
                    votes
                </g:else>

            </header>

            <g:each in="${votes}" var="vote">

                <g:set var="message" value="${vote.message}"/>

                <article id="vote">

                    <g:if test="${ message instanceof stacklack.Issue }">

                        <g:if test="${message.resolved == true}">
                            <div id="resolved" style="background-color : #82B21A ;"></div>
                        </g:if>
                        <g:else>
                            <div id="resolved" style="background-color : #242424 ;"></div>
                        </g:else>
                    
                        <div id="type">
                            Q
                        </div>

                        <div id="title">
                            <h1><g:link controller="question" action="show" id="${message.id}">${message.title}</g:link></h1>
                        </div>

                    </g:if>

                    <g:if test="${ message instanceof stacklack.Answer }">

                        <g:if test="${message.helped == true}">
                            <div id="resolved" style="background-color : #82B21A ;"></div>
                        </g:if>
                        <g:else>
                            <div id="resolved" style="background-color : #242424 ;"></div>
                        </g:else>
                    
                        <div id="type">
                            A
                        </div>

                        <div id="title">
                            <h1><g:link controller="question" action="show" id="${message.issue.id}">${message.issue.title}</g:link></h1>
                        </div>
                        
                    </g:if>

                    <div id="voteType">
                        <g:if test="${vote.vote == 1}">
                            +1
                        </g:if>
                        <g:else>
                            -1
                        </g:else>
                    </div>

                </article>

            </g:each>

        </section>

        <section>

            <article id="tag">

                <span class="header">Tags</span>

                <g:each in="${tags}" var="tag">

                    <g:link controller="shared" action="displayTag" id="${tag.id}">${tag.text}</g:link>
                    
                </g:each>

            </article>

        </section>

        <g:include controller="shared" action="footer"/>

    </body>

</html>