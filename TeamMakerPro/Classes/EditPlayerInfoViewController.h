//
//  EditPlayerInfoViewController.h
//  TeamMakerPro
//
//  Created by Will Fairclough on 11-08-06.
//  Copyright 2011 Superna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditPlayerInfoViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *attributes;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UITextField *txtFirstName;
@property (strong, nonatomic) UITextField *txtLastName;
@property (strong, nonatomic) UITextField *txtEmail;
@property (strong, nonatomic) UITextField *txtHandicap;
@property (strong, nonatomic) UITextField *txtBirthday;


@end
