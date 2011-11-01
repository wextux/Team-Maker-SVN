//
//  Profile.h
//  TeamMakerPro
//
//  Created by Will Fairclough on 11-08-10.
//  Copyright (c) 2011 Superna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Team;

@interface Profile : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * dateCreated;
@property (nonatomic, retain) NSString * owner;
@property (nonatomic, retain) NSString * number;
@property (nonatomic, retain) NSSet *teams;
@end

@interface Profile (CoreDataGeneratedAccessors)

- (void)addTeamsObject:(Team *)value;
- (void)removeTeamsObject:(Team *)value;
- (void)addTeams:(NSSet *)values;
- (void)removeTeams:(NSSet *)values;

@end
