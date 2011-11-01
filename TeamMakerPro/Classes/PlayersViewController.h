//
//  PlayersViewController.h
//  TeamMakerPro
//
//  Created by Will Fairclough on 11-08-12.
//  Copyright (c) 2011 Superna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Team.h"
#import "PlayerCell.h"

@interface PlayersViewController : UITableViewController

@property (nonatomic, strong) Team *team;

@property (nonatomic, retain) UINib *cellNib;
@property (strong, nonatomic) PlayerCell *playerCell;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil team:(Team *)newTeam;


@end
