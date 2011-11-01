//
//  DetailViewController.h
//  TeamMakerPro
//
//  Created by Will Fairclough on 11-08-04.
//  Copyright 2011 Superna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSplitViewController.h"
#import "Team.h"
#import "Profile.h"

@interface DetailViewController : UITableViewController <NSFetchedResultsControllerDelegate, UIPopoverControllerDelegate, MGSplitViewControllerDelegate, NSFetchedResultsControllerDelegate, UISearchBarDelegate, UIAlertViewDelegate> {


    IBOutlet MGSplitViewController *splitController;
	
    UIPopoverController *popoverController;
    UIToolbar *toolbar;
    
    
    
}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *playerFetchedResultsController;
@property (strong, nonatomic) NSFetchedResultsController *profileFetchedResultsController;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *togglePlayersBarItem;

@property (strong, nonatomic) NSArray *teams;
@property (strong, nonatomic) Profile *profile;

//@property (strong, nonatomic) IBOutlet UITextField *txtFirstName;
//@property (strong, nonatomic) IBOutlet UITextField *txtLastName;
//@property (strong, nonatomic) IBOutlet UITextField *txtemail;
//@property (strong, nonatomic) IBOutlet UISlider *sldHandicap;
//@property (strong, nonatomic) IBOutlet UILabel *lblHandicapSlider;

- (IBAction)showModelTeamView:(Team *)team;


- (void)createTeams;
- (IBAction)toggleMasterView:(id)sender;
- (IBAction)toggleVertical:(id)sender;
- (IBAction)toggleDividerStyle:(id)sender;
- (IBAction)toggleMasterBeforeDetail:(id)sender;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil context:(NSManagedObjectContext *)context;

@end
