//
//  Person+CoreDataProperties.h
//  CoreDataDemo
//
//  Created by tropsci on 15/11/24.
//  Copyright © 2015年 topsci. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) Card *card;

@end

NS_ASSUME_NONNULL_END
