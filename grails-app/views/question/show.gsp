<!DOCTYPE html>
<html>
    <head>
        <title>Welcome to Stacklack</title>
        <link rel="stylesheet" type="text/css" href="/assets/question.css">
    </head>
    <body>

        <script>
            /* alert message when you have not enough reputation for an action */
            function notEnoughReputation(number)
            {
                alert("You don't have enough reputation to do that!\n You need " + number + " reputation points.")
            }

            /* allow to display comment textarea for connected users */
            function display_comment(id)
            {
                hide = 'comment_hidden_' + id
                show = 'comment_shown_' + id
                
                if (document.getElementById(hide).style.display != 'block')
                {
                    document.getElementById(show).style.display = 'none';
                    document.getElementById(hide).style.display = 'block';
                }
            }
        </script>

        <!-- inclusion of the navigation bar -->
        <g:include controller="shared" action="nav" id="${user?.id}"/>

        <section>

            <!-- presentation of the question -->
            <article id="issue">

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

                    <h1>${issue.title}</h1>

                    <g:each in="${issue.tags}" var="tag">
                        <span id="tag">
                            <g:link controller="shared" action="displayTag" id="${tag.id}">
                                ${tag.text}
                            </g:link>&nbsp;
                        </span>
                    </g:each>

                    asked by <g:link controller="shared" action="dashboard" id="${issue.user.id}">${issue.user.username}</g:link> - 

                    <g:if test="${issue.lastUpdated > issue.dateCreated}">
                        modify : <g:formatDate format="dd/MM/yy HH:mm:ss" date="${issue.lastUpdated}"/>
                    </g:if>
                    <g:else>
                        create : <g:formatDate format="dd/MM/yy HH:mm:ss" date="${issue.dateCreated}"/>
                    </g:else>

                    <g:if test="${user?.id == issue.user.id}">
                        -
                        <g:form action="rewrite" name="rewriteForm">
                            <g:hiddenField name="issue.id" value="${issue.id}"/>
                            <g:hiddenField name="user.id" value="${user.id}"/>
                            <g:actionSubmitImage class="icon" value="modify" action="rewrite" src="${resource(dir: 'img', file: 'stacklack/modify.png')}" />
                        </g:form>

                        - 
                        <g:link controller="question" action="resolved" id="${issue.id}">
                            <img class="icon" alt="resolved ?" title="resolved ?" src="<g:resource dir="img" file="stacklack/resolved_helped.png" />" />
                        </g:link>

                        <!-- - delete -->
                    </g:if>

                </div>

                <div id="hide">

                    <span class="block">

                    <div id="vote_plus">

                        <g:if test="${user != null}">

                            <g:if test="${user.reputation >= 15}">
                                
                                <g:set var="vote" value="${votes.find( { v -> v.message == issue } )?.vote }" />

                                <g:if test="${vote == 1}">

                                    <g:link controller="question" action="vote_plus" id="${issue.id}">
                                        
                                        <img alt="vote_plus" title="vote_plus" src="<g:resource dir="img" file="stacklack/vote_plus_voted.png" />" />
                                    
                                    </g:link>

                                </g:if>

                                <g:else>

                                    <g:link controller="question" action="vote_plus" id="${issue.id}">
                                     
                                        <img alt="vote_plus" title="vote_plus" src="<g:resource dir="img" file="stacklack/vote_plus.png" />" />
                                    
                                    </g:link>

                                </g:else>

                            </g:if>

                            <g:else>

                                <img alt="vote_plus" title="vote_plus" src="<g:resource dir="img" file="stacklack/vote_plus.png" />" onclick="notEnoughReputation(15);" />
                            
                            </g:else>

                        </g:if>

                    </div>

                    <div id="vote">
                        ${issue.voteScore}
                        <g:if test="${issue.voteScore >= -1 && issue.voteScore <= 1}">
                            vote
                        </g:if>
                        <g:else>
                            votes
                        </g:else>
                    </div>

                    <div id="vote_minus">

                        <g:if test="${user != null}">

                            <g:if test="${user.reputation >= 15}">
                                
                                <g:set var="vote" value="${votes.find( { v -> v.message == issue } )?.vote }" />

                                <g:if test="${vote == -1}">

                                    <g:link controller="question" action="vote_minus" id="${issue.id}">
                                        
                                        <img alt="vote_minus_voted" title="vote_minus_voted" src="<g:resource dir="img" file="stacklack/vote_minus_voted.png" />" />
                                    
                                    </g:link>

                                </g:if>

                                <g:else>

                                    <g:link controller="question" action="vote_minus" id="${issue.id}">
                                     
                                        <img alt="vote_minus" title="vote_minus" src="<g:resource dir="img" file="stacklack/vote_minus.png" />" />
                                    
                                    </g:link>

                                </g:else>

                            </g:if>

                            <g:else>

                                <img alt="vote_minus" title="vote_minus" src="<g:resource dir="img" file="stacklack/vote_minus.png" />" onclick="notEnoughReputation(15);" />
                            
                            </g:else>

                        </g:if>

                    </div>

                    </span>

                </div>

                <div id="text">
                    ${issue.text}
                </div>

            </article>

            <g:each in="${issue.comments}" var="comment">
            
                <article id="comment">
                
                    ${comment.text}
                    <span class="block">
                        - <g:link controller="shared" action="dashboard" id="${comment.user.id}">${comment.user.username}</g:link> -
                        <g:formatDate format="dd/MM/yy HH:mm:ss" date="${comment.lastUpdated}"/>

                        <g:if test="${user?.id == comment.user.id}">
                            -
                            <g:form action="" name="Form">
                                <g:hiddenField name="issue.id" value="${issue.id}"/>
                                <g:hiddenField name="user.id" value="${user.id}"/>
                                <g:actionSubmitImage class="icon" value="modify" action="" src="${resource(dir: 'img', file: 'stacklack/modify.png')}" />
                            </g:form>
                            <!-- - delete -->
                        </g:if>
                    </span>

                </article>
            
            </g:each>

            <g:if test="${user != null}">

                <span id="comment_shown_${issue.id}">

                    <article id="comment">
                        <g:if test="${user.reputation >= 50}">
                            <input type="button" value="add a comment" onclick="display_comment(${issue.id});"/>
                        </g:if>
                        <g:else>
                            <input type="button" value="add a comment" onclick="notEnoughReputation(50);"/>
                        </g:else>
                    </article>

                </span>

                <span id="comment_hidden_${issue.id}" style="display : none ;">

                    <article id="comment">

                        <g:form action="comment" name="commentForm">
                            <g:textArea class="input" name="text" style="min-height : 49px ; resize : vertical ;" rows="2" cols="78"/>
                            <g:hiddenField name="issue.id" value="${issue.id}"/>
                            <g:hiddenField name="user.id" value="${user.id}"/>
                            <g:actionSubmitImage class="input" value="comment" action="comment" src="${resource(dir: 'img', file: 'stacklack/check.png')}" />
                        </g:form>

                    </article>

                </span>

            </g:if>

        </section>

        <section>

            <header>

                ${issue.answers.count.size}
                <g:if test="${issue.answers.count.size < 1}">
                    answer
                </g:if>
                <g:else>
                    answers
                </g:else>

            </header>

            <div id="sort">
                <ul>
                    <g:if test="${sort == '0'}">
                        <li class="hover">New</li>
                    </g:if>
                    <g:else>
                        <li><g:link controller="question" action="show" id="${issue.id}">New</g:link></li>
                    </g:else>

                    <g:if test="${sort == '1'}">
                        <li class="hover">Helped</li>
                    </g:if>
                    <g:else>
                        <li><g:link controller="question" action="show" id="${issue.id}" params="[sort: 1]">Helped</g:link></li>
                    </g:else>

                    <g:if test="${sort == '2'}">
                        <li class="hover">Upvoted</li>
                    </g:if>
                    <g:else>
                        <li><g:link controller="question" action="show" id="${issue.id}" params="[sort: 2]">Upvoted</g:link></li>
                    </g:else>
                </ul>
            </div>

            <!-- presentation of all answers of this question -->
            <g:each in="${answers}" var="answer">
            
                <article id="answer">
                    
                    <g:if test="${answer.helped == true}">
                        <div id="helped" style="background-color : #82B21A ;"></div>
                    </g:if>
                    <g:else>
                        <div id="helped" style="background-color : #EEEEEE ;"></div>
                    </g:else>
                    
                    <div id="text">

                        ${answer.text}
                        
                        <span class="block">
                            - <g:link controller="shared" action="dashboard" id="${answer.user.id}">${answer.user.username}</g:link> -
                            <g:formatDate format="dd/MM/yy HH:mm:ss" date="${answer.lastUpdated}"/>

                            <g:if test="${user?.id == answer.user.id}">
                                -
                                <g:form action="" name="Form">
                                    <g:hiddenField name="answer.id" value="${answer.id}"/>
                                    <g:hiddenField name="user.id" value="${user.id}"/>
                                    <g:actionSubmitImage class="icon" value="modify" action="" src="${resource(dir: 'img', file: 'stacklack/modify.png')}" />
                                </g:form>

                            </g:if>

                            <g:if test="${user?.id == issue.user.id}">

                                - 
                                <g:link controller="question" action="helped" id="${answer.id}">
                                    <img class="icon" alt="helped ?" title="helped ?" src="<g:resource dir="img" file="stacklack/resolved_helped.png" />" />
                                </g:link>
                                <!-- - delete -->
                            </g:if>
                        </span>

                    </div>

                    <div id="hide">

                        <span class="block">

                        <div id="vote_plus">

                            <g:if test="${user != null}">

                                <g:if test="${user.reputation >= 15}">
                                    
                                    <g:set var="vote" value="${votes.find( { v -> v.message == answer } )?.vote }" />

                                    <g:if test="${vote == 1}">

                                        <g:link controller="question" action="vote_plus" id="${answer.id}">
                                            
                                            <img alt="vote_plus" title="vote_plus" src="<g:resource dir="img" file="stacklack/vote_plus_voted.png" />" />
                                        
                                        </g:link>

                                    </g:if>

                                    <g:else>

                                        <g:link controller="question" action="vote_plus" id="${answer.id}">
                                         
                                            <img alt="vote_plus" title="vote_plus" src="<g:resource dir="img" file="stacklack/vote_plus.png" />" />
                                        
                                        </g:link>

                                    </g:else>

                                </g:if>

                                <g:else>

                                    <img alt="vote_plus" title="vote_plus" src="<g:resource dir="img" file="stacklack/vote_plus.png" />" onclick="notEnoughReputation(15);" />
                                
                                </g:else>

                            </g:if>

                        </div>

                        <div id="vote">
                            ${answer.voteScore}
                            <g:if test="${answer.voteScore >= -1 && answer.voteScore <= 1}">
                                vote
                            </g:if>
                            <g:else>
                                votes
                            </g:else>
                        </div>

                        <div id="vote_minus">
                            
                            <g:if test="${user != null}">

                                <g:if test="${user.reputation >= 15}">
                                    
                                    <g:set var="vote" value="${votes.find( { v -> v.message == answer } )?.vote }" />

                                    <g:if test="${vote == -1}">

                                        <g:link controller="question" action="vote_minus" id="${answer.id}">
                                            
                                            <img alt="vote_minus_voted" title="vote_minus_voted" src="<g:resource dir="img" file="stacklack/vote_minus_voted.png" />" />
                                        
                                        </g:link>

                                    </g:if>

                                    <g:else>

                                        <g:link controller="question" action="vote_minus" id="${answer.id}">
                                         
                                            <img alt="vote_minus" title="vote_minus" src="<g:resource dir="img" file="stacklack/vote_minus.png" />" />
                                        
                                        </g:link>

                                    </g:else>

                                </g:if>

                                <g:else>

                                    <img alt="vote_minus" title="vote_minus" src="<g:resource dir="img" file="stacklack/vote_minus.png" />" onclick="notEnoughReputation(15);" />
                                
                                </g:else>

                            </g:if>

                        </div>

                        </span>

                    </div>

                </article>

                <div class="clear"></div>
            
                <g:each in="${answer.comments}" var="comment">
                
                    <article id="comment">
                    
                        ${comment.text}
                        <span class="block">
                            - <g:link controller="shared" action="dashboard" id="${comment.user.id}">${comment.user.username}</g:link> -
                            <g:formatDate format="dd/MM/yy HH:mm:ss" date="${comment.lastUpdated}"/>

                            <g:if test="${user?.id == comment.user.id}">
                                -
                                <g:form action="" name="Form">
                                    <g:hiddenField name="issue.id" value="${issue.id}"/>
                                    <g:hiddenField name="user.id" value="${user.id}"/>
                                    <g:actionSubmitImage class="icon" value="modify" action="" src="${resource(dir: 'img', file: 'stacklack/modify.png')}" />
                                </g:form>
                                <!-- - delete -->
                            </g:if>
                        </span>

                    </article>
                
                </g:each>
                
                <g:if test="${user != null}">

                    <span id="comment_shown_${answer.id}">

                        <article id="comment">

                            <g:if test="${user.reputation >= 50}">
                                <input type="button" value="add a comment" onclick="display_comment(${answer.id});"/>
                            </g:if>
                            <g:else>
                                <input type="button" value="add a comment" onclick="notEnoughReputation(50);"/>
                            </g:else>

                        </article>

                    </span>

                    <span id="comment_hidden_${answer.id}" style="display : none ;">

                        <article id="comment">

                            <g:form action="comment" name="commentForm">
                                <g:textArea class="input" name="text" style="min-height : 49px ; resize : vertical ;" rows="2" cols="78"/>
                                <g:hiddenField name="answer.id" value="${answer.id}"/>
                                <g:hiddenField name="user.id" value="${user.id}"/>
                                <g:actionSubmitImage class="input" value="comment" action="comment" src="${resource(dir: 'img', file: 'stacklack/check.png')}" />
                            </g:form>

                        </article>

                    </span>

                </g:if>

            </g:each>

        </section>

        <g:if test="${user != null}">

            <section>

                <header>

                    new answer

                </header>

                <article id="newAnswer">

                    <g:form action="answer" name="answerForm">
                        <g:textArea class="input" name="text" style="min-height : 49px ; resize : vertical ;" rows="2" cols="80"/>
                        <g:hiddenField name="helped" value="false"/>
                        <g:hiddenField name="issue.id" value="${issue.id}"/>
                        <g:hiddenField name="user.id" value="${user.id}"/>
                        <g:actionSubmitImage class="input" value="answer" action="answer" src="${resource(dir: 'img', file: 'stacklack/check.png')}" />
                    </g:form>

                </article>

            </section>

        </g:if>


        <div class="clear"></div>
        
        <!-- inclusion of the footer -->
        <g:include controller="shared" action="footer"/>

    </body>
</html>