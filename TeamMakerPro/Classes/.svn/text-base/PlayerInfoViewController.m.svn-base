//
//  PlayerInfoViewController.m
//  TeamMakerPro
//
//  Created by Ben Fairclough on 11-08-06.
//  Copyright 2011 Superna. All rights reserved.
//

#import "PlayerInfoViewController.h"
#import "TeamMakerProAppDelegate.h"
#import "MasterViewController.h"

@implementation PlayerInfoViewController
@synthesize attributes = _attributes;
@synthesize txtFirstName, txtLastName, txtEmail, txtBirthday, txtHandicap;
@synthesize tableView = _tableView;
@synthesize player = _player;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize surroundingPopoverController = _surroundingPopoverController;
@synthesize navigationController = _navigationController;
@synthesize tabBar = _tabBar;
@synthesize tabBarController = tabBarController;
@synthesize imageView;
@synthesize imagePicker = _imagePicker;
@synthesize thumbnailImage;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.clearsSelectionOnViewWillAppear = NO;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 355.0);
        _tableView.scrollEnabled = NO;
    } else {
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 480.0);
    }
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44.0, 320.0, 333.0) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    
    _attributes = [NSArray arrayWithObjects:@"First Name", @"Last Name", @"Email", @"Handicap", @"Birthdate", nil];
    
    txtFirstName = [[UITextField alloc] initWithFrame:CGRectMake(105, 10, 150, 30)];
    [txtFirstName setPlaceholder:@"first name"];
    [txtFirstName setAutocorrectionType:UITextAutocorrectionTypeNo];

    
    txtLastName = [[UITextField alloc] initWithFrame:CGRectMake(105, 10, 150, 30)];
    [txtLastName setPlaceholder:@"last name"];
    [txtLastName setAutocorrectionType:UITextAutocorrectionTypeNo];

    
    txtEmail = [[UITextField alloc] initWithFrame:CGRectMake(105, 10, 150, 30)];
    [txtEmail setPlaceholder:@"email"];
    [txtEmail setKeyboardType:UIKeyboardTypeEmailAddress];
    [txtEmail setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [txtEmail setAutocorrectionType:UITextAutocorrectionTypeNo];
    
    
    txtHandicap = [[UITextField alloc] initWithFrame:CGRectMake(105, 10, 150, 30)];
    [txtHandicap setPlaceholder:@"handicap"];
    
    txtBirthday = [[UITextField alloc] initWithFrame:CGRectMake(105, 10, 150, 30)];
    [txtBirthday setPlaceholder:@"birthdate"];
    
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction:)];
    
    self.navigationItem.rightBarButtonItem = cancelButton;

    isCanceling = NO;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    NSLog(@" TEST" );
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillDisappear:(BOOL)animated 
{
    if (isCanceling == NO)
        [self savePlayer];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - Table View Support

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return _attributes.count;//[_fetchedObjects count];//[sectionInfo numberOfObjects];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
        NSString *rowTitle = [_attributes objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = rowTitle;
        
        
        if ([rowTitle isEqualToString:@"First Name"]) {
            [cell.contentView addSubview:txtFirstName];
        } else if ([rowTitle isEqualToString:@"Last Name"]) {
            [cell.contentView addSubview:txtLastName];
        } else if ([rowTitle isEqualToString:@"Email"]) {
            [cell.contentView addSubview:txtEmail];
        } else if ([rowTitle isEqualToString:@"Handicap"]) {
            [cell.contentView addSubview:txtHandicap];
        } else if ([rowTitle isEqualToString:@"Birthdate"]) {
            [cell.contentView addSubview:txtBirthday];
        }
        
        if (_player == nil) {
            [txtFirstName becomeFirstResponder];
        }

    }
    
    // Configure the cell.
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
}


- (NSIndexPath *)tableView :(UITableView *)tv willSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    return indexPath;
}   


#pragma mark - UIImagePickerViewController Support

- (void)imagePickerControllerDidCancel:(UIImagePickerController *) Picker {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [self dismissModalViewControllerAnimated:YES];
    } else {
        [self.tabBarController dismissModalViewControllerAnimated:YES];
    }
    _imagePicker = nil;

}


- (void)imagePickerController:(UIImagePickerController *) Picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    UIImage *newImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [imageView setBackgroundImage:newImage forState:UIControlStateNormal];
    thumbnailImage = newImage;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [self dismissModalViewControllerAnimated:YES];
    } else {
        [self.tabBarController dismissModalViewControllerAnimated:YES];
    }
    [self savePlayer];
}

#pragma mark - Action Sheet Support

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (buttonIndex == 0) {
        _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            [self presentModalViewController:_imagePicker animated:YES];
        } else {
            [self.tabBarController presentModalViewController:_imagePicker animated:YES];
        }
    } else if (buttonIndex == 1) {
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            [self presentModalViewController:_imagePicker animated:YES];
        } else {
            [self.tabBarController presentModalViewController:_imagePicker animated:YES];
        }
    } else if (buttonIndex == 2) {
        // Cancel
    }
    
}



#pragma mark - Actions

- (IBAction)chooseImage:(id)sender {
    
    _imagePicker = [[UIImagePickerController alloc] init];
    
    [_imagePicker setDelegate:self];
    
    
    UIActionSheet *newImageActionSheet;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        newImageActionSheet = [[UIActionSheet alloc] initWithTitle:@"New Image" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Choose a Photo", @"Take a Photo", nil];
        newImageActionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            [newImageActionSheet showInView:self.view];
        } else {
            [newImageActionSheet showFromTabBar:_tabBar];
        }
    } else {
        _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentModalViewController:_imagePicker animated:YES];
    }
    
    

}

- (IBAction)cancelAction:(id)sender {

    isCanceling = YES;
    
    // Close View Properly depending on device
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        if (_surroundingPopoverController != nil) {
            TeamMakerProAppDelegate *appDelegate = (TeamMakerProAppDelegate *)[[UIApplication sharedApplication] delegate];
            
            [appDelegate.masterViewController exitDrill];
        }
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)savePlayer {   

    isCanceling = NO;
    
     NSEntityDescription *entity = [NSEntityDescription entityForName:@"Player" inManagedObjectContext:_managedObjectContext];
    
    // Check for Errors
    if (txtFirstName.text==NULL || txtLastName.text==NULL) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Information Missing" message:@"Please give the person a first and last name." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else {
        if(_player == nil) {
            Player *newPlayer = [NSEntityDescription insertNewObjectForEntityForName:[entity name]inManagedObjectContext:_managedObjectContext];
            newPlayer.firstName = txtFirstName.text;
            newPlayer.lastName = txtLastName.text;
            newPlayer.handicap= [NSNumber numberWithInt:[txtHandicap.text intValue]];
            newPlayer.emailAddress = txtEmail.text;
            newPlayer.thumbnailPic = thumbnailImage;
        } else {
            _player.firstName = txtFirstName.text;
            _player.lastName = txtLastName.text;
            _player.handicap= [NSNumber numberWithInt:[txtHandicap.text intValue]];
            _player.emailAddress = txtEmail.text;
            _player.thumbnailPic = thumbnailImage;
        }
    
        
        // Save the context.
        NSError *error = nil;
        if (![_managedObjectContext save:&error])
        {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
    

        // Close View Properly depending on device
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            
            if (_surroundingPopoverController != nil) {
                TeamMakerProAppDelegate *appDelegate = (TeamMakerProAppDelegate *)[[UIApplication sharedApplication] delegate];
                
                [appDelegate.masterViewController exitDrill];
            }
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
}



@end
