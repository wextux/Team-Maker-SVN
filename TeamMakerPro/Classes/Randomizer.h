//
//  Randomizer.h
//  TeamMakerPro
//
//  Created by Will Fairclough on 11-08-07.
//  Copyright 2011 Superna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Randomizer : NSObject


- (NSArray *) shufflePlayers:(NSArray *)players;
- (NSArray *) createTeamsWithPlayers:(NSArray *)players numberOfPlayersPerTeam:(int)num intoContext:(NSManagedObjectContext *)context;
@end
