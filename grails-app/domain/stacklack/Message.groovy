package stacklack

class Message {

	Date dateCreated
	
	Date lastUpdated
	
	String text
	
	Integer voteScore = 0

    static constraints = {
	
		text( blank : false,
			  size : 0..1500 )
	
		voteScore( nullable : true )
    }

	static hasMany = [ votes : Vote ]
    
}
