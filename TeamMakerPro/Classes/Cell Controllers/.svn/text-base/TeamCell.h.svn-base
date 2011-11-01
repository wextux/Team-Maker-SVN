//
//  TeamCell.h
//  TeamMakerPro
//
//  Created by Will Fairclough on 11-08-11.
//  Copyright (c) 2011 Superna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"


@interface TeamCell : UITableViewCell <UITableViewDelegate, UITableViewDataSource> {
    BOOL useDarkBackground;
}

@property BOOL useDarkBackground;
@property (nonatomic, strong) IBOutlet UIImageView *logoImage;
@property (nonatomic, strong) IBOutlet UILabel *teamNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *teamScoreLabel;
@property (nonatomic, strong) IBOutlet UILabel *numOfPlayersLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *players;

@end
