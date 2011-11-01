//
//  MasterViewController.m
//  TeamMakerPro
//
//  Created by Will Fairclough on 11-08-04.
//  Copyright 2011 Superna. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Player.h"
#import "PlayerInfoViewController.h"
#import "PlayerCell.h"


@interface MasterViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation MasterViewController

@synthesize detailViewController = _detailViewController;
@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize searchBar = _searchBar;
@synthesize fetchedObjects = _fetchedObjects;
@synthesize playerCell, cellNib;

//@synthesize newPlayerPopoverController = _newPlayerPopoverController;
//@synthesize editPlayerViewController = playerInfoViewController;
//@synthesize playerInfoViewController = playerInfoViewController;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Players", @"Players");
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            self.clearsSelectionOnViewWillAppear = NO;
            self.contentSizeForViewInPopover = CGSizeMake(200.0, 600.0);
            
        }
        id delegate = [[UIApplication sharedApplication] delegate];
        self.managedObjectContext = [delegate managedObjectContext];
    }
    return self;
}

- (id) init {
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"Master", @"Master");
        id delegate = [[UIApplication sharedApplication] delegate];
        self.managedObjectContext = [delegate managedObjectContext];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)selectFirstRow
{
	if ([self.tableView numberOfSections] > 0 && [self.tableView numberOfRowsInSection:0] > 0) {
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
		[self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
		[self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
	}
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed: @"green_background.png"]];
//    [self.tableView setBackgroundColor:[UIColor clearColor]];
//    
//    NSString *backgroundPath = [[NSBundle mainBundle] pathForResource:@"green_background" ofType:@"png"];
//    UIImage *backgroundImage = [UIImage imageWithContentsOfFile:backgroundPath];
//    UIColor *backgroundColor = [[UIColor alloc] initWithPatternImage:backgroundImage];
//
//    self.tableView.backgroundColor = backgroundColor; 
    
    
    CGFloat red = 3.0f/255.0f;
    CGFloat green = 137.0f/255.0f;
    CGFloat blue = 156.0f/255.0f;

    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:red green:green blue:blue alpha:1.0f]];
	// Do any additional setup after loading the view, typically from a nib.
    // Set up the edit and add buttons.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addressBookUI:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    
    _searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    _searchBar.delegate = self;
    
    [self featchAllPlayers];
    
    selectable = YES;
    
    
    if ([[self.fetchedResultsController fetchedObjects] count] >= 1) {
        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [[self tableView] scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    
    self.cellNib = [UINib nibWithNibName:@"PlayerCell_iPhone" bundle:nil];

    
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - Table View Protocol Methods 

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [self.fetchedResultsController.fetchedObjects count];//[_fetchedObjects count];//[sectionInfo numberOfObjects];
}

// Sets the height for all rows to be 80
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    return 80;
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    PlayerCell *cell = (PlayerCell *)[tableView dequeueReusableCellWithIdentifier:nil];
    
    if (cell == nil) {
        [self.cellNib instantiateWithOwner:self options:nil];
        cell = playerCell;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    // Display dark and light background in alternate rows -- see tableView:willDisplayCell:forRowAtIndexPath:.
    cell.useDarkBackground = YES;//(indexPath.row % 2 == 0);
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
    
    
//    static NSString *CellIdentifier = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleGray;
//    }
//
//    // Configure the cell.
//    [self configureCell:cell atIndexPath:indexPath];
//    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the managed object for the given index path
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        //[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];

        // Save the context.
        NSError *error = nil;
        if (![context save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }   
    
//    [tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectable) {
        Player *selectedPlayer = [[self fetchedResultsController] objectAtIndexPath:indexPath];

        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
            playerInfoViewController = [[PlayerInfoViewController alloc] initWithNibName:@"PlayerInfoViewController" bundle:nil];
            [playerInfoViewController setManagedObjectContext:self.managedObjectContext];
            playerInfoViewController.navigationController = self.navigationController;
            playerInfoViewController.tabBar = self.tabBarController.tabBar;
            playerInfoViewController.tabBarController = self.tabBarController;
            //playerInfoViewController.modalPresentationStyle = UIModalPresentationFormSheet;
            //playerInfoViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;  //transition shouldn't matter
            //[self presentModalViewController:playerInfoViewController animated:YES];
            [self.navigationController pushViewController:playerInfoViewController animated:YES];

                
        } else {

            CGRect aFrame = [self.tableView rectForRowAtIndexPath:indexPath];
            
            if ((playerInfoViewController == nil) || (newPlayerPopoverController == nil)) {
                playerInfoViewController = [[PlayerInfoViewController alloc] initWithNibName:@"PlayerInfoViewController" bundle:nil];
                playerInfoViewController.navigationController = [[UINavigationController alloc] initWithRootViewController:playerInfoViewController];
                newPlayerPopoverController = [[UIPopoverController alloc] initWithContentViewController:playerInfoViewController.navigationController];

                [newPlayerPopoverController presentPopoverFromRect:[self.tableView convertRect:aFrame toView:self.view] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
                
                newPlayerPopoverController.delegate = self;
        
                playerInfoViewController.surroundingPopoverController = newPlayerPopoverController;
                
            } else {
                [newPlayerPopoverController dismissPopoverAnimated:YES];
                playerInfoViewController = nil;
                newPlayerPopoverController = nil;
            }

            
        }
        
        playerInfoViewController.title = [NSString stringWithFormat:@"%@ %@", selectedPlayer.firstName, selectedPlayer.lastName];
        playerInfoViewController.thumbnailImage = selectedPlayer.thumbnailPic;
        [playerInfoViewController.imageView setBackgroundImage:selectedPlayer.thumbnailPic forState:UIControlStateNormal];
        [playerInfoViewController.txtFirstName setText:selectedPlayer.firstName];
        [playerInfoViewController.txtLastName setText:selectedPlayer.lastName];
        [playerInfoViewController.txtEmail setText:selectedPlayer.emailAddress];
        [playerInfoViewController.txtHandicap setText:[NSString stringWithFormat:@"%i",[selectedPlayer.handicap intValue]]];
        [playerInfoViewController.txtBirthday setText:[NSString stringWithFormat:@"%@",selectedPlayer.dateOfBirth]]; 
        [playerInfoViewController setPlayer:selectedPlayer];
        playerInfoViewController.managedObjectContext = self.managedObjectContext;
        
    }
}


- (NSIndexPath *)tableView :(UITableView *)tv willSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    [_searchBar resignFirstResponder];
    [tv becomeFirstResponder];
    
    if (selectable) {
        return indexPath;
    } else {
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addressBookUI:)];
        self.navigationItem.rightBarButtonItem = addButton;
        selectable = YES;
        return nil;
    }
    
}   

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed: @"green_background.png"]]];
//}

#pragma mark - Search Bar Support


- (void) doneSearching_Clicked:(id)sender {
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addressBookUI:)];
    self.navigationItem.rightBarButtonItem = addButton;
    [self.searchBar resignFirstResponder];
    [self.searchBar setText:@""];
    
    [self.fetchedResultsController.fetchRequest setPredicate:nil];
    
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error])
    {
        // Handle error
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    } 
    
    // this array is just used to tell the table view how many rows to show
    //_fetchedObjects = self.fetchedResultsController.fetchedObjects;
    [self featchAllPlayers];
    
    [self.tableView reloadData];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    selectable = NO;
//    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneSearching_Clicked:)];
//    self.navigationItem.rightBarButtonItem = doneButton;
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
//    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneSearching_Clicked:)];
//    self.navigationItem.rightBarButtonItem = doneButton;
    
    // We use an NSPredicate combined with the fetchedResultsController to perform the search
    NSNumber *indexLength = [NSNumber numberWithInt:(_searchBar.text.length - 1)];
    if (![self.searchBar.text isEqualToString:@""])
    {
        
        if (![[_searchBar.text substringFromIndex:[indexLength intValue]] isEqualToString:@" "]) {
            
            NSArray *array = [_searchBar.text componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            NSArray *searchComponents = [array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"length > 0"]];
            
            if ([array count] > 1) {
                NSMutableArray *firstNamePredicates = [[NSMutableArray alloc] init];
                for (NSString *tmpString in searchComponents) {
                    
                    NSPredicate *firstNamePredicate =[NSPredicate predicateWithFormat:@"firstName beginsWith[c] %@", tmpString];
                    
                    [firstNamePredicates addObject:firstNamePredicate];
                    
                }
                
                NSPredicate *comFirstNamePredicate = [NSCompoundPredicate orPredicateWithSubpredicates:firstNamePredicates];
                
                
                NSMutableArray *lastNamePredicates = [[NSMutableArray alloc] init];
                for (NSString *tmpString in searchComponents) {
                    
                    NSPredicate *lastNamePredicate =[NSPredicate predicateWithFormat:@"lastName beginsWith[c] %@", tmpString];
                    [lastNamePredicates addObject:lastNamePredicate];
                    
                }
                
                NSPredicate *comLastNamePredicate = [NSCompoundPredicate orPredicateWithSubpredicates:lastNamePredicates];
                
                
                NSArray *predicates = [NSArray arrayWithObjects:comFirstNamePredicate, comLastNamePredicate, nil];
                
                
                NSPredicate *comPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:predicates];
                [self.fetchedResultsController.fetchRequest setPredicate:comPredicate];
            } else {
                NSPredicate *firstNamePredicate =[NSPredicate predicateWithFormat:@"firstName beginsWith[c] %@", _searchBar.text];
                NSPredicate *lastNamePredicate =[NSPredicate predicateWithFormat:@"lastName beginsWith[c] %@", _searchBar.text];
                
                NSArray *predicates = [NSArray arrayWithObjects:firstNamePredicate, lastNamePredicate, nil];
                
                
                NSPredicate *comPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:predicates];
                [self.fetchedResultsController.fetchRequest setPredicate:comPredicate];
            }
            
        }
    }
    else
    {
        [self.fetchedResultsController.fetchRequest setPredicate:nil];
    }
    
    
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error])
    {
        // Handle error
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    } 

    // this array is just used to tell the table view how many rows to show
    _fetchedObjects = [self.fetchedResultsController fetchedObjects];
    
    // dismiss the search keyboard
    // [self.searchBar resignFirstResponder];
    
    // reload the table view
    [self.tableView reloadData];
    
}


#pragma mark - Fetched results controller

- (void) featchAllPlayers 
{
    [self.fetchedResultsController.fetchRequest setPredicate:nil];
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error])
    {
        // Handle error
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        exit(-1);  // Fail
    } 
    _fetchedObjects = [self.fetchedResultsController fetchedObjects];
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (__fetchedResultsController != nil)
    {
        return __fetchedResultsController;
    }
    
    /*
     Set up the fetched results controller.
    */
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Player" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *firstNameSD = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    NSSortDescriptor *lastNameSD = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:lastNameSD, firstNameSD, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error])
        {
	    /*
	     Replace this implementation with code to handle the error appropriately.

	     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
	     */
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return __fetchedResultsController;
}    

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type)
    {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}


// Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 


- (void)configureCell:(PlayerCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Player *player = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", player.firstName, player.lastName];
    cell.detailLabel.text = [NSString stringWithFormat:@"Handicap: %i",[player.handicap intValue]];
    if (player.thumbnailPic != NULL) {
        [cell.thumbnailImage setImage:player.thumbnailPic];
    }
}

#pragma mark - Address Book UI Support

- (void)peoplePickerNavigationControllerDidCancel:
(ABPeoplePickerNavigationController *)peoplePicker {
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    
    return NO;
}


- (BOOL)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    

    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Player" inManagedObjectContext:self.managedObjectContext];
    Player *newPlayer = [[Player alloc] initWithEntity:entity insertIntoManagedObjectContext:__managedObjectContext];
    
    
    
    // Get image from address book and store it in Transformable Attibute of Player
    UIImage *thumbnailImage;
    
    
    if ( &ABPersonCopyImageDataWithFormat != nil ) {
        // iOS >= 4.1
        thumbnailImage = [UIImage imageWithData:(__bridge NSData *)ABPersonCopyImageDataWithFormat(person, kABPersonImageFormatThumbnail)];
    } else {
        // iOS < 4.1
        thumbnailImage = [UIImage imageWithData:(__bridge NSData *)ABPersonCopyImageData(person)];
    }
    
    if (thumbnailImage != nil) 
        newPlayer.thumbnailPic = thumbnailImage;
    
    

    ABMultiValueRef multiEmail = ABRecordCopyValue(person, kABPersonEmailProperty);
    
    if (ABMultiValueGetCount(multiEmail) > 0) { // Check if email addess exist
        CFStringRef emailRef = ABMultiValueCopyValueAtIndex(multiEmail, 0);
        CFRelease(multiEmail);
        NSString *emailAddress = (__bridge NSString *) emailRef;
        CFRelease(emailRef);
        newPlayer.emailAddress = [NSString stringWithFormat:@"%@", emailAddress];
    }

    NSDate *birthdate = (__bridge NSDate *) ABRecordCopyValue(person, kABPersonBirthdayProperty);
    if (birthdate != NULL) {
        newPlayer.dateOfBirth = birthdate;
    } else {
        newPlayer.dateOfBirth = [NSDate date];
    }
    
    
    NSString* name = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    if (name != NULL) {
        newPlayer.firstName = name;
    } else {
        newPlayer.lastName = @"";
    }

    
    name = (__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
    if (name != NULL) {
        newPlayer.lastName = name;
    } else {
        newPlayer.lastName = @"";
    }
    
    newPlayer.handicap = [NSNumber numberWithInt:100];

    // Save the context.
    NSError *error = nil;
    if (![__managedObjectContext save:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    [self dismissModalViewControllerAnimated:YES];
    
    return NO;
}


#pragma mark - Popover View Support

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    playerInfoViewController = nil;
    newPlayerPopoverController = nil;
}

- (void) exitDrill {
    if(newPlayerPopoverController != nil){
        [newPlayerPopoverController dismissPopoverAnimated: YES];
        newPlayerPopoverController = nil;
        playerInfoViewController = nil;
    }
}


#pragma mark - Actions

- (void)insertNewPlayer:(id)sender
{

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {

        if ((playerInfoViewController == nil) || (newPlayerPopoverController == nil)) {
            playerInfoViewController = [[PlayerInfoViewController alloc] initWithNibName:@"PlayerInfoViewController" bundle:nil];
            [playerInfoViewController setManagedObjectContext:self.managedObjectContext];
            newPlayerPopoverController = [[UIPopoverController alloc] initWithContentViewController:playerInfoViewController];
             [playerInfoViewController setManagedObjectContext:self.managedObjectContext];
            [newPlayerPopoverController presentPopoverFromBarButtonItem:sender 
                                            permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            newPlayerPopoverController.delegate = self;
            playerInfoViewController.surroundingPopoverController = newPlayerPopoverController;
        } else {
            [newPlayerPopoverController dismissPopoverAnimated:YES];
            playerInfoViewController = nil;
            newPlayerPopoverController = nil;
        }
    } else {
        playerInfoViewController = [[PlayerInfoViewController alloc] initWithNibName:@"PlayerInfoViewController" bundle:nil];
        [playerInfoViewController setManagedObjectContext:self.managedObjectContext];
        
        playerInfoViewController.modalPresentationStyle = UIModalPresentationFormSheet;
        playerInfoViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;  //transition shouldn't matter
        [self presentModalViewController:playerInfoViewController animated:YES];
        
    }
}


- (IBAction) addressBookUI:(id)sender {
    
    ABPeoplePickerNavigationController *picker =
    [[ABPeoplePickerNavigationController alloc] init];
    picker.modalPresentationStyle = UIModalPresentationFormSheet;
    picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    picker.peoplePickerDelegate = self;
    
    [self presentModalViewController:picker animated:YES];
}





@end