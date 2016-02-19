<!DOCTYPE html>
<html>
    <head>
        <title>Welcome to Stacklack</title>
        <link rel="stylesheet" type="text/css" href="/assets/question.css">
    </head>
    <body>

        <!-- inclusion of the navigation bar -->
        <g:include controller="shared" action="nav" id="${user?.id}"/>

        <section>

        	<header>

                <g:if test="${issue == null}">
                    Ask your question
                </g:if>
                <g:else>
                    Modify your question
                </g:else>

            </header>

            <article id="newQuestion">

                <g:if test="${issue == null}">
                    <g:form class="form" action="ask" name="questionForm">
                        
                        <g:textField name="title" style="width : 494px ;" placeholder="Title" />
                        <g:select name="language" from="${['C', 'C++', 'C#', 'Java', 'Groovy', 'HTML', 'PHP', 'Ruby', 'Javascript', 'Python', 'Other']}" defaultValue="['':'- Choose the language -']" noSelection="['':'- Choose the language -']"/>
                        <g:textArea name="text" style="min-height : 75px ; resize : vertical ; width : 700px ;" placeholder="Text" />
                        <g:textField name="tags" style="width : 600px ;" placeholder="Tags (ex: HTML CSS Javascript)" />

                        <g:hiddenField name="edit" value="false"/>
                        <g:hiddenField name="user.id" value="${user.id}"/>
                        <g:hiddenField name="resolved" value="false"/>
                        <g:hiddenField name="voteScore" value="0"/>

                        <g:actionSubmit class="submit" value="ask" action="ask" />
                        
                    </g:form>
                </g:if>
                <g:else>
                    <g:form class="form" action="modify" name="questionForm">
                        
                        <g:textField name="title" style="width : 494px ;" value="${issue.title}" />
                        <g:select name="language" from="${['C', 'C++', 'C#', 'Java', 'Groovy', 'HTML', 'PHP', 'Ruby', 'Javascript', 'Python', 'Other']}" value="${issue.language}" defaultValue="['':'- Choose the language -']" noSelection="['':'- Choose the language -']"/>
                        <g:textArea name="text" style="min-height : 75px ; resize : vertical ; width : 700px ;" value="${issue.text}" />
                        <g:textField name="tags" style="width : 600px ;" value="${tags}" />
                        
                        <g:hiddenField name="edit" value="true"/>
                        <g:hiddenField name="issue.id" value="${issue.id}"/>
                        <g:hiddenField name="user.id" value="${user.id}"/>
                        <g:hiddenField name="resolved" value="false"/>
                        <g:hiddenField name="voteScore" value="0"/>

                        <g:actionSubmit class="submit" value="modify" action="modify" />
                        
                    </g:form>
                </g:else>

            </article>

        </section>

    	<!-- inclusion of the footer -->
        <g:include controller="shared" action="footer"/>

    </body>
</html>