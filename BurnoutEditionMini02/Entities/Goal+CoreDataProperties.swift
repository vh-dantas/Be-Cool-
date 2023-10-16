//
//  Goal+CoreDataProperties.swift
//  BurnoutEditionMini02
//
//  Created by João Victor Bernardes Gracês on 26/09/23.
//
//

import Foundation
import CoreData


extension Goal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal> {
        return NSFetchRequest<Goal>(entityName: "Goal")
    }

    @NSManaged public var isCompleted: Bool
    @NSManaged public var title: String?
    @NSManaged public var id: UUID?
    @NSManaged public var createdDate: Date?
    @NSManaged public var subGoals: NSSet?
    @NSManaged public var reflection: ReflectionEntity?
    
    public var subGoalsArray: [SubGoal] {
        let setOfSubGoals = subGoals as? Set<SubGoal> ?? []
        return setOfSubGoals.sorted{
            $0.id > $1.id
        }
    }
    
    

}

// MARK: Generated accessors for subGoals
extension Goal {

    @objc(addSubGoalsObject:)
    @NSManaged public func addToSubGoals(_ value: SubGoal)

    @objc(removeSubGoalsObject:)
    @NSManaged public func removeFromSubGoals(_ value: SubGoal)

    @objc(addSubGoals:)
    @NSManaged public func addToSubGoals(_ values: NSSet)

    @objc(removeSubGoals:)
    @NSManaged public func removeFromSubGoals(_ values: NSSet)

}

extension Goal : Identifiable {

}
