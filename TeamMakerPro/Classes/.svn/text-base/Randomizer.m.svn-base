//
//  Randomizer.m
//  TeamMakerPro
//
//  Created by Will Fairclough on 11-08-07.
//  Copyright 2011 Superna. All rights reserved.
//

#import "Randomizer.h"
#import "Team.h"
#import "Player.h"

@implementation Randomizer


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (NSArray *) createTeamsWithPlayers:(NSArray *)players numberOfPlayersPerTeam:(int)num intoContext:(NSManagedObjectContext *)context {
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Team" inManagedObjectContext:context];
    double actualTeamCount = ((float)[players count]/(float)num);
    int numOfTeams = ceil(actualTeamCount);
    double diff = (actualTeamCount - floor(actualTeamCount));
    int numPlayersForLastTeam = (diff != 0.0f) ?
    (diff * num) : num;
        

//    if (numPlayersForLastTeam <= (num/2)) {
//        int numOfTeamsForNewLimit = (num/2);
//    }


    NSMutableArray *teams = [[NSMutableArray alloc] initWithCapacity:numOfTeams];
    
    players = [self shufflePlayers:[NSMutableArray arrayWithArray:players]];

    for (int teamNum = 1; teamNum <= numOfTeams; teamNum++) {
    
        int limit = (((teamNum-1)*num)+(num-1));
        // If we are on the last team 
        if (teamNum == numOfTeams) {  // Make it (teamNum > (numOfTeams - numOfTeamsForNewLimit))
            limit = (((teamNum-1)*num)+(numPlayersForLastTeam-1));
        }
        
        if (((teamNum-1)*num) <= limit) {
            Team *team = [[Team alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
            [team setName:[NSString stringWithFormat:@"Team %i",teamNum]];
            [team setNumber:[NSNumber numberWithInt:teamNum]];
            [team setDateCreated:[NSDate date]];
            

            
            for (int playerNum = ((teamNum-1)*num); playerNum <= limit; playerNum++) {
                Player *player = [players objectAtIndex:playerNum];
                [team addPlayersObject:player];
            }
    
            [teams addObject:team];
        }
        
    }
    
    return teams;
    
} 

- (NSArray *) shufflePlayers:(NSMutableArray *)players {
    srandom(time(NULL));
    
    NSUInteger count = [players count];
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        int nElements = count - i;
        int n = (random() % nElements) + i;
        [players exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    
    return players;
}

@end
