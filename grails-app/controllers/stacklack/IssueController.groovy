package stacklack

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import org.springframework.security.access.annotation.Secured

@Transactional(readOnly = true)
class IssueController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    @Secured( ['ROLE_ADMIN'] )
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Issue.list(params), model:[issueCount: Issue.count()]
    }

    @Secured( ['ROLE_ADMIN'] )
    def show(Issue issue) {
        respond issue
    }

    @Secured( ['ROLE_ADMIN'] )
    def create() {
        respond new Issue(params)
    }

    @Transactional
    def save(Issue issue) {
        if (issue == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (issue.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond issue.errors, view:'create'
            return
        }

        issue.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'issue.label', default: 'Issue'), issue.id])
                redirect issue
            }
            '*' { respond issue, [status: CREATED] }
        }
    }

    @Secured( ['ROLE_ADMIN'] )
    def edit(Issue issue) {
        respond issue
    }

    @Transactional
    def update(Issue issue) {
        if (issue == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (issue.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond issue.errors, view:'edit'
            return
        }

        issue.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'issue.label', default: 'Issue'), issue.id])
                redirect issue
            }
            '*'{ respond issue, [status: OK] }
        }
    }

    @Transactional
    def delete(Issue issue) {

        if (issue == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        issue.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'issue.label', default: 'Issue'), issue.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'issue.label', default: 'Issue'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
