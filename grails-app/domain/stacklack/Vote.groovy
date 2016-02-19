package stacklack

class Vote {

	Integer vote = 0

	static belongsTo = [ message : Message,
						 user : User ]

    static constraints = {
	
		vote( range : -1..1 )
	
		message( nullable : false,
				 validator :
				 { val, obj ->
					 if( val instanceof Comment )
					 {
						 return false ;
					 }
				 } )
		
		user( nullable : false )
	
    }
    
}
