import stacklack.Role
import stacklack.User
import stacklack.UserRole

class BootStrap {

    def init = { servletContext ->
        
        /* two roles and two users by default */

        def adminRole = new Role(authority: 'ROLE_ADMIN').save(flush: true)
        def userRole = new Role(authority: 'ROLE_USER').save(flush: true)

        def admin = new User(username: 'admin', enabled: true, password: 'admin', email: 'admin@mail.com')
        admin.save(flush: true)
        admin.reputation = 1000
        admin.save()
        
        def user = new User(username: 'lambda', enabled: true, password: 'lambda', email: 'lambda@mail.com')
        user.save(flush: true)

        UserRole.create admin, adminRole, true
        UserRole.create user, userRole, true
        
    }
    
    def destroy = {
    }
}
