package stacklack

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@EqualsAndHashCode(includes='username')
@ToString(includes='username', includeNames=true, includePackage=false)
class User implements Serializable {

	private static final long serialVersionUID = 1

	transient springSecurityService

	String username
	String password
	String profile
	String email
	boolean enabled = true
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired
	Integer reputation = 0

	User(String username, String password, String email) {
		this()
		this.username = username
		this.password = password
		this.email = email
	}

	Set<Role> getAuthorities() {
		UserRole.findAllByUser(this)*.role
	}

	def beforeInsert() {
		encodePassword()
	}

	def beforeUpdate() {
		if (isDirty('password')) {
			encodePassword()
		}
	}

	protected void encodePassword() {
		password = springSecurityService?.passwordEncoder ? springSecurityService.encodePassword(password) : password
	}

	static transients = ['springSecurityService']

	static constraints = {
		username blank: false, unique: true
		password blank: false
		email blank: false, unique: true, email: true
		profile nullable: true, size: 0..1500
	}

	static mapping = {
		password column: '`password`'
	}

	static hasMany = [ issues : Issue,
                       answers : Answer,
                       comments : Comment,
                       tags : Tag,
                       votes : Vote,
                       badges : Badge ]
}
