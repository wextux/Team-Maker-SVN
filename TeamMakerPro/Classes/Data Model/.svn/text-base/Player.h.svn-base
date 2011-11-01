//
//  Player.h
//  TeamMakerPro
//
//  Created by Will Fairclough on 11-08-12.
//  Copyright (c) 2011 Superna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Team;

@interface Player : NSManagedObject

@property (nonatomic, retain) NSDate * dateOfBirth;
@property (nonatomic, retain) NSString * emailAddress;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSNumber * handicap;
@property (nonatomic, retain) NSNumber * isMale;
@property (nonatomic, retain) NSNumber * isPlaying;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * numberofWins;
@property (nonatomic, retain) UIImage * thumbnailPic;
@property (nonatomic, retain) NSSet *teams;
@end

@interface Player (CoreDataGeneratedAccessors)

- (void)addTeamsObject:(Team *)value;
- (void)removeTeamsObject:(Team *)value;
- (void)addTeams:(NSSet *)values;
- (void)removeTeams:(NSSet *)values;

@end
