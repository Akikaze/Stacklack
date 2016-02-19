package stacklack

class SharedController {

    def footer()
    {
        println "Shared - Footer"
    }

    def nav(User user)
    {
        println "Shared - Nav"

        /* completely useless but still funny */

        /* http://www.rhymezone.com/r/rhyme.cgi?typeofrhyme=perfect&Word=back&loc=spellmap3 */
        def mottos = ["avoid the heart attack !",
                      "we need your feedback !",
                      "don't forget the jetpack"]
        def random = new Random()
        def motto = mottos.get( random.nextInt( mottos.size() ) )
        /* ---------- ------- --- ----- ----- */

        return [user: user, motto: motto]
    }

    def login()
    {
        println "Shared - Login"
    }

    def loging()
    {
        println "Shared - Loging"

        redirect controller: "login", action: "authenticate"
    }

    def signup()
    {
        println "Shared - Signup"
    }

    def signing()
    {
        println "Shared - Signing"

        /* creation of an user */
        User user = new User( params )
        user.save()

        if( !user.hasErrors() ) 
        {
            redirect controller: "home", action: "index"
        }
        else
        {
            println "ERROR signing"
        }
    }

    def displayTag(Tag tag)
    {
        println "Shared - DisplayTag"

        /* find the tag */
        List tags = Tag.list()
        tags = tags.sort( { it -> it.text == tag.text } )
        
        /* find all issues which contain this tag */
        List issues = Issue.list()
        issues.clear()

        for( Tag tagElement: tags )
        {
            if( tagElement.text == tag.text )
            {
                issues.add( tagElement.issue )
            }
        }

        return [ tag: tag.text, issues: issues ]
    }

    def dashboard(User user)
    {
        println "Shared - Dashboard"

        def name = session.SPRING_SECURITY_CONTEXT?.getAuthentication()?.getPrincipal()?.getUsername()
        def dashboard = false
        if( name == user.username )
        {
            dashboard = true
        }

        List posts = null

        posts = new ArrayList< Message >()
        posts.addAll( user.issues )
        posts.addAll( user.answers )
        posts.sort( { it -> it.lastUpdated } )

        def tags = user.tags
        tags = tags.unique( { it -> it.text } )        

        return [user: user, dashboard: dashboard, tags: tags, posts: posts, votes: user.votes]
    }

    def modify()
    {
        println "Shared - Modify"

        User user = User.get( params.user.id )
        user.profile = params.profile
        user.save()

        if( !user.hasErrors() ) 
        {
            redirect controller: "shared", action: "dashboard", id: user.id
        }
        else
        {
            println "ERROR modify"
        }
    }

}
