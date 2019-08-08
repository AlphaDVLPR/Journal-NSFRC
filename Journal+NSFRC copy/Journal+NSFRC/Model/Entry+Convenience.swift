//
//  Entry+Convenience.swift
//  Journal+NSFRC
//
//  Created by Karl Pfister on 5/9/19.
//  Copyright © 2019 Karl Pfister. All rights reserved.
//

import Foundation
import CoreData

extension Entry {
    
    ///DECLARE OUR CONVENIENCE INITIALIZER. WE ARE ADDING A DEFAULT FOR OUR MOC AND DATE. WE CALL THE MEMBERWISE INIT OF ENTRY AND INIT IT WITH OUR CONTEXT.
    
    convenience init(title : String, body : String, timestamp : Date = Date(), context : NSManagedObjectContext = CoreDataStack.context) {
        
        //For Memberwise
        self.init(context : context)
        
        //For Convienence
        self.title = title
        self.body = body
        self.timestamp = timestamp
    }
}
