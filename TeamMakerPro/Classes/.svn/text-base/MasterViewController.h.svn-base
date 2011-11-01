//
//  MasterViewController.h
//  TeamMakerPro
//
//  Created by Will Fairclough on 11-08-04.
//  Copyright 2011 Superna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@class DetailViewController;

#import <CoreData/CoreData.h>
#import "PlayerInfoViewController.h"
#import "PlayerCell.h"

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate, UISearchBarDelegate, UIPopoverControllerDelegate, ABPeoplePickerNavigationControllerDelegate> {
    BOOL selectable;
    UIPopoverController *newPlayerPopoverController;
    PlayerInfoViewController *playerInfoViewController;
}

@property (strong, nonatomic) IBOutlet DetailViewController *detailViewController;
//@property (strong, nonatomic) EditPlayerInfoViewController *editPlayerViewController;
//@property (retain, nonatomic) PlayerInfoViewController *playerInfoViewController;
//@property (retain, nonatomic) UIPopoverController *newPlayerPopoverController;


@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSArray *fetchedObjects;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, retain) UINib *cellNib;
@property (strong, nonatomic) IBOutlet PlayerCell *playerCell;

- (void)insertNewPlayer:(id)sender;
- (void) doneSearching_Clicked:(id)sender;
- (void) featchAllPlayers;
- (void) exitDrill;
- (IBAction)addressBookUI:(id)sender;

@end
