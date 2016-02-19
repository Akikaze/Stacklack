package stacklack

class Badge {

	String name

	static belongsTo = [ user : User ]

    static constraints = {

    	name( nullable : false )
		user( nullable : false )

    }
}
