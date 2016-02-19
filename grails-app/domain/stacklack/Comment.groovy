package stacklack

class Comment extends Message {

	static belongsTo = [ answer : Answer,
						 issue : Issue,
						 user : User ]

    static constraints = {
	
		answer( nullable : true )
		
		issue( nullable : true,
			   validator :
			   { val, obj ->
				   if( val == null && obj.answer == null )
				   {
					   return false ;
				   }
				   else if( val != null && obj.answer != null )
				   {
					   return false ;
				   }
			   } )
		
		user( nullable : false )
	
    }
    
}
