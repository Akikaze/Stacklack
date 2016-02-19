package stacklack

class Issue extends Message {

    String language
    
    boolean resolved
    
    String title

    Integer views = 0

    static belongsTo = [ user : User ]

    static constraints = {
    
        language( inList : ['C',
                            'C++',
                            'C#',
                            'Java',
                            'Groovy',
                            'HTML',
                            'PHP',
                            'Ruby',
                            'Javascript',
                            'Python',
                            'Other'] )
        
        title( blank : false, size : 0..250 )
        
        user( nullable : false )
    
    }
    
    static hasMany = [ answers : Answer,
                       comments : Comment,
                       tags : Tag ]
    

    static mapping = {

        answers sort: 'lastUpdated', order: 'desc'
        comments sort: 'lastUpdated', order: 'desc'
        tag sort: 'text', order: 'asc'

    }

}
