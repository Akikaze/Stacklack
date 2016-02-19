package stacklack

import org.springframework.security.access.annotation.Secured

class QuestionController {

    User user = null

    def index() { }
    
    def show(Issue issue)
    {
        println "Question - Show"

        issue.views = issue.views + 1
        issue.save()

        /* same way to find an user connection as the HomeController */

        def name = session.SPRING_SECURITY_CONTEXT?.getAuthentication()?.getPrincipal()?.getUsername()
        List users = User.list()

        List votes = Vote.list()
        votes.clear()

        List favorites = Issue.list()
        favorites.clear()

        if( name != null )
        {
            user = users.find( { u -> u.username == name } )

            /* list of all votes made by this user on this question and its answers */
            Vote vote = issue.votes.find( { v -> v.user == user } )
            if( vote != null )
            {
                votes.add( vote )
            }

            for( Answer answer: issue.answers )
            {
                vote = answer.votes.find( { v -> v.user == user } )
                if( vote != null )
                {
                    votes.add( vote )
                }
            }
            
        }
        else
        {
            user = null
        }

        /* FILTERS */
        def sort = '0'
        if( params.sort != null )
        {
            sort = params.sort
        }

        /* by default, it is sorted by date */
        def answers = issue.answers
        switch ( sort )
        {
            case '1' :
                /* helped answers */
                answers = answers.findAll( { it.helped == true } )
                break ;

            case '2' :
                /* upvoted question */
                answers = answers.sort( { -it.voteScore } )
                break ;
        }
        /* ------- */

        return [user: user, issue: issue, answers: answers, votes: votes, sort: sort]
    }

    @Secured( ['ROLE_USER', 'ROLE_ADMIN'] )
    def write(User user)
    {
        println "Question - Write"

        Issue issue
        def tags = ""

        if( params.issue_id != null )
        {
            issue = Issue.get( params.issue_id )
            issue.tags.each( { tags = tags + it.text + " " } )
        }

        return [user: user, issue: issue, tags: tags]
    }

    @Secured( ['ROLE_USER', 'ROLE_ADMIN'] )
    def rewrite()
    {
        println "Question - Rewrite"
        redirect controller: "question", action: "write", id: params.user.id, params: [issue_id: params.issue.id]
        
    }

    def ask()
    {
        println "Question - Ask"

        def name = session.SPRING_SECURITY_CONTEXT?.getAuthentication()?.getPrincipal()?.getUsername()
        User user = User.list().find( { u -> u.username == name } )
        user.reputation = user.reputation + 5 

        /* creation of the new Question */
        def listTags = params.tags
        params.tags = ""

        Issue issue = new Issue( params )
        issue.lastUpdated = issue.dateCreated
        issue.save()

        if( !issue.hasErrors() ) 
        {
            /* parse of each tags */
            StringTokenizer tok = new StringTokenizer( listTags )
            while( tok.hasMoreElements() )
            {
                Tag tag = new Tag()
                tag.text = tok.nextElement()
                tag.issue = issue
                tag.user = User.get( params.user.id )
                tag.save()

                if( tag.hasErrors() )
                {
                    tag.errors.each { println "ERROR tag : " + it }
                }
            }

            redirect controller: "home", action: "index"
        }
        else
        {
            println "ERROR ask"   
        }
    }

    def modify()
    {
        println "Question - Modify"

        Issue issue = Issue.get( params.issue.id )
        def listTags = issue.tags

        /* parse of each tags */
        StringTokenizer tok = new StringTokenizer( params.tags )
        while( tok.hasMoreElements() )
        {
            def tagText = tok.nextElement()
            def found = listTags.find( { t -> t.text == tagText } ) 

            if( found == null )
            {
                Tag tag = new Tag()
                tag.text = tagText
                tag.issue = issue
                tag.user = User.get( params.user.id )
                tag.save()

                if( tag.hasErrors() )
                {
                    tag.errors.each { println "ERROR tag : " + it }
                }
            }
            else
            {
                listTags.remove( found )
            }
        }

        listTags.each( {
            issue.tags.remove( it )
            issue.user.tags.remove( it )
            it.delete()
        } )

        issue.text = params.text
        issue.title = params.title
        issue.language = params.language

        redirect controller: "home", action: "index"
    }

    def resolved(Issue issue)
    {
        issue.user.reputation = issue.user.reputation + 10
        issue.user.save()

        issue.resolved = true
        issue.save()

        if( !issue.hasErrors() ) 
        {
            redirect controller: "home", action: "index"
        }
        else
        {
            println "ERROR issue"   
        }
    }

    def helped(Answer answer)
    {
        answer.user.reputation = answer.user.reputation + 10
        answer.user.save()

        answer.helped = true
        answer.save()

        if( !answer.hasErrors() ) 
        {
            redirect controller: "question", action: "show", id: answer.issue.id
        }
        else
        {
            println "ERROR answer"   
        }
    }

    def comment()
    {
        println "Question - Comment"

        /* creation of the new Comment */
        Comment comment = new Comment( params )
        comment.save()
        
        if( !comment.hasErrors() ) 
        {
            def name = session.SPRING_SECURITY_CONTEXT?.getAuthentication()?.getPrincipal()?.getUsername()
            User user = User.list().find( { u -> u.username == name } )
            user.reputation = user.reputation + 5

            if( params.issue != null )
            {
                /* if it's the question, you are redirected to the question */
                redirect action: "show", id: params.issue.id
            }
            else
            {
                /* if it's an answer of the question, you are redirected to the question */
                Answer answer = Answer.get( params.answer.id )
                redirect action: "show", id: answer.issue.id
            }
        }
        else
        {
            println "ERROR comment"   
        }
    }
    
    def answer()
    {
        println "Question - Answer"

        def name = session.SPRING_SECURITY_CONTEXT?.getAuthentication()?.getPrincipal()?.getUsername()
        User user = User.list().find( { u -> u.username == name } )
        user.reputation = user.reputation + 5

        /* creation of the new Answer */
        Answer answer = new Answer( params )
        answer.save()
        
        if( !answer.hasErrors() ) 
        {
            redirect action: "show", id: params.issue.id 
        }
        else
        {
            println "ERROR answer"   
        }
    }
    
    private def redirect_message(Message message)
    {
        println "Question - Redirect"

        /* automatically redirect for an update of vote */

        if( message.getClass() == Issue )
        {
            /* redirect to the question */
            redirect action: "show", id: message.id   
        }
        else
        {
            /* redirect to the question stacked in the answer */
            redirect action: "show", id: message.issue.id
        }
    }
    
    def vote_plus(Message message)
    {
        println "Question - Voteplus"

        Vote vote = message.votes.find( { v -> v.user = user } )

        /* if vote == 0 */
        if( vote == null )
        {
            /* creation of a vote */
            vote = new Vote()
            vote.vote = 1
            vote.message = message
            vote.user = user
            vote.save()

            if( !vote.hasErrors() ) 
            {
                /* vote = 1 */
                message.voteScore = message.voteScore + 1
            }
            else
            {
                println "ERROR vote_plus"   
            }
        }
        /* if vote == 1 */
        else if( vote.vote == 1 )
        {
            /* vote = 0 */
            message.votes.remove( vote )
            vote.delete() ;
            message.voteScore = message.voteScore - 1
        }
        /* if vote == -1 */
        else
        {
            /* vote = 1 */
            vote.vote = 1
            message.voteScore = message.voteScore + 2
        }

        redirect_message( message )        
    }
    
    def vote_minus(Message message)
    {
        println "Question - Voteminus"

        Vote vote = message.votes.find( { v -> v.user = user } )

        /* if vote == 0 */
        if( vote == null )
        {
            /* creation of a vote */
            vote = new Vote()
            vote.vote = -1
            vote.message = message
            vote.user = user
            vote.save()

            if( !vote.hasErrors() ) 
            {
                /* vote = -1 */
                message.voteScore = message.voteScore - 1
            }
            else
            {
                println "ERROR vote_minus"   
            }
        }
        /* if vote == -1 */
        else if( vote.vote == -1 )
        {
            /* vote = 0 */
            message.votes.remove( vote )
            vote.delete() ;
            message.voteScore = message.voteScore + 1
        }
        /* if vote == 1 */
        else
        {
            /* vote = -1 */
            vote.vote = -1
            message.voteScore = message.voteScore - 2
        }

        redirect_message( message )      
    }

}
