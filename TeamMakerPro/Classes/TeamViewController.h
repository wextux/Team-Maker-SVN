//
//  TeamViewController.h
//  TeamMakerPro
//
//  Created by Will Fairclough on 11-08-11.
//  Copyright (c) 2011 Superna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Profile.h"
#import "TeamCell.h"


@interface TeamViewController : UITableViewController 


@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) Profile *profile;
@property (strong, nonatomic) NSArray *teams;
@property (nonatomic, retain) UINib *cellNib;
@property (strong, nonatomic) IBOutlet TeamCell *teamCell;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil profile:(Profile *)newProfile;
- (IBAction)editProfile:(id)sender;

@end
