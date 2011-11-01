//
//  EditPlayerInfoViewController.m
//  TeamMakerPro
//
//  Created by Will Fairclough on 11-08-06.
//  Copyright 2011 Superna. All rights reserved.
//

#import "EditPlayerInfoViewController.h"

@implementation EditPlayerInfoViewController
@synthesize attributes = _attributes;
@synthesize txtFirstName, txtLastName, txtEmail, txtBirthday, txtHandicap;
@synthesize tableView = _tableview;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(300.0, 240.0);
    
    _attributes = [NSArray arrayWithObjects:@"First Name", @"Last Name", @"Email", @"Handicap", @"Birthdate", nil];
    
    txtFirstName = [[UITextField alloc] initWithFrame:CGRectMake(105, 10, 150, 30)];
    [txtFirstName setPlaceholder:@"first name"];
    
    txtLastName = [[UITextField alloc] initWithFrame:CGRectMake(105, 10, 150, 30)];
    [txtLastName setPlaceholder:@"last name"];
    
    txtEmail = [[UITextField alloc] initWithFrame:CGRectMake(105, 10, 150, 30)];
    [txtEmail setPlaceholder:@"email"];
    
    txtHandicap = [[UITextField alloc] initWithFrame:CGRectMake(105, 10, 150, 30)];
    [txtHandicap setPlaceholder:@"handicap"];
    
    txtBirthday = [[UITextField alloc] initWithFrame:CGRectMake(105, 10, 150, 30)];
    [txtBirthday setPlaceholder:@"birthdate"];
    
    _tableview.delegate = self;
    _tableview.dataSource = self;
    
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _attributes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
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
    }
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
