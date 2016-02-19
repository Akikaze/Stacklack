package stacklack

class Answer extends Message {

	boolean helped

	static belongsTo = [ issue : Issue,
						 user : User ]

    static constraints = {
	
		/* helped( display : false ) */
	
		issue( nullable : false )
	
		user( nullable : false )
	
    }
	
	static hasMany = [ comments : Comment ]

	static mapping = {

		comments sort: 'lastUpdated', order: 'asc'

	}
	
}