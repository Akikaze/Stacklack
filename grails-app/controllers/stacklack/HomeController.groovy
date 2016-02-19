package stacklack

import org.springframework.security.access.annotation.Secured

class HomeController {

    def index() {

        println "Home - Index"

        List issues = Issue.list()

        /* USER CONNECTION */
        def name = session.SPRING_SECURITY_CONTEXT?.getAuthentication()?.getPrincipal()?.getUsername()
        List users = User.list()
        User user = null

        if( name != null )
        {
            user = users.find( { u -> u.username == name } )
        }
        /* ---- ---------- */

        /* FILTERS */
        def sort = '0'
        if( params.sort != null )
        {
            sort = params.sort
        }

        /* by default, it is sorted by date */

        switch ( sort )
        {
            default :
                /* lastUpdated question */
                issues = issues.sort( { it.lastUpdated } ).reverse()
                break ;

            case '1' :
                /* no resolved question */
                issues = issues.sort( { it.lastUpdated } ).reverse()
                issues = issues.findAll( { it.resolved == false } )
                break ;

            case '2' :
                /* upvoted question */
                issues = issues.sort( { -it.voteScore } )
                break ;
        }
        /* ------- */

        return [user: user, issues: issues, sort: sort]

    }
}
