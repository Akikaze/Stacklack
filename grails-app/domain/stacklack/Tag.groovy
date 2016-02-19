package stacklack

class Tag {

	String text

	static belongsTo = [ issue : Issue,
						 user : User ]

    static constraints = {
	
		issue( nullable : false )
		
		text( blank : false,
			  size : 0..50 )

		user( nullable : false,
			  validator :
			  { val, obj ->
			  	  if( obj.issue.user != val )
			  	  {
			  	      return false ;
			  	  }
			  } )
		
    }
    
}
