//
//  Teachers.m
//  Agenda 2
//
//  Created by Lee Hamilton on 12/5/11.
//  Copyright 2011 Lee Hamilton. All rights reserved.
//

#import "Teachers.h"
#import "TeachersDetails.h"
#import "Agenda_2AppDelegate.h"

@implementation Teachers
@synthesize tName,tRoom,tEmail,tPhone,tWeb, teachersTableView;
@synthesize teachersArray,teacherClassDetails,addTeacherView;

-(void)setTeacherName:(NSString *)theTeacherName withRoom:(NSString *)teacherRoom withEmail:(NSString *)teacherEmail withPhone:(NSString *)teacherPhone andWeb:(NSString *)teacherWeb{
    tName = theTeacherName;
    tRoom = teacherRoom;
    tEmail = teacherEmail;
    tPhone = teacherPhone;
    tWeb = teacherWeb;
}

-(void)insertItemToTable{
    [teachersDetailsArray addObject:[NSArray arrayWithObjects:tName,tRoom,tEmail,tPhone,tWeb, nil]];
    [teachersArray addObject:tName];
    [teachersTableView reloadData];
}

-(void)addItemToToolbar{
    if (addTeacherView == nil) {
        addTeacherView = [[AddTeacher alloc]init];
    }
    [addTeacherView setDelegate:self];
    [self presentModalViewController:addTeacherView animated:YES];
}

-(void)saveAllData:(NSNotification *)notification{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *detailsPath = [NSString stringWithFormat:@"%@/teachersDetails.plist", [paths objectAtIndex:0]];
    NSString *tablePath = [NSString stringWithFormat:@"%@/teachersTable.plist",[paths objectAtIndex:0]];
    
    @try {
        [teachersDetailsArray writeToFile:detailsPath atomically:YES];
        [teachersArray writeToFile:tablePath atomically:YES];
        NSLog(@"Saving data successful!");
    }
    @catch (NSException *e) {
        NSLog(@"*******************");
        NSLog(@"*** ERROR: %@", e);
        NSLog(@"*******************");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"ERROR" message:@"An error occured while saving. Please try again." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    
}

-(void)loadData{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *detailsPath = [NSString stringWithFormat:@"%@/teachersDetails.plist", [paths objectAtIndex:0]];
    NSString *tablePath = [NSString stringWithFormat:@"%@/teachersTable.plist",[paths objectAtIndex:0]];
    
    @try {
        [teachersDetailsArray addObjectsFromArray:[NSMutableArray arrayWithContentsOfFile:detailsPath]];
        [teachersArray addObjectsFromArray:[NSMutableArray arrayWithContentsOfFile:tablePath]];
        [teachersTableView reloadData];
        NSLog(@"Loading data successful!");
    }
    @catch (NSException *e) {
        NSLog(@"*******************");
        NSLog(@"*** ERROR: %@", e);
        NSLog(@"*******************");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"ERROR" message:@"An error occured while loading. Please try again." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
        //Custom init
        teachersArray = [[NSMutableArray alloc]init];
        teachersDetailsArray = [[NSMutableArray alloc]init];
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
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItemToToolbar)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveAllData:) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(insertItemToTable) name:@"TeacherDonePressed" object:nil];
    
    [self loadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.navigationItem.rightBarButtonItem = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    return [teachersArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    [cell.textLabel setText:[teachersArray objectAtIndex:[indexPath row]]];
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


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [teachersArray removeObjectAtIndex:[indexPath row]];
        NSLog(@"schedualArray: %@",teachersArray);
        [teachersDetailsArray removeObjectAtIndex:[indexPath row]];
        NSLog(@"scheduleDetails: %@", teachersDetailsArray);
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


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
    
    TeachersDetails *detailViewController = [[TeachersDetails alloc] initWithNibName:@"TeachersDetails" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    detailViewController.title = [NSString stringWithFormat:@"%@", [teachersArray objectAtIndex:[indexPath row]]];
    [self.navigationController pushViewController:detailViewController animated:YES];
    detailViewController.lTeacherName.text = detailViewController.title;
    //NSLog(@"\n%@\n",[scheduleDetails objectAtIndex:indexPath.row]);
    detailViewController.lTeacherRoom.text = [[teachersDetailsArray objectAtIndex:indexPath.row] objectAtIndex:1];
    detailViewController.lTeacherEmail.text = [[teachersDetailsArray objectAtIndex:indexPath.row] objectAtIndex:2];
    detailViewController.lTeacherPhone.text = [[teachersDetailsArray objectAtIndex:indexPath.row] objectAtIndex:3];
    detailViewController.lTeacherWeb.text = [[teachersDetailsArray objectAtIndex:indexPath.row] objectAtIndex:4];
    [detailViewController release];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //self.navigationItem.rightBarButtonItem = nil;
    [teacherClassDetails release];
    [super dealloc];
}

@end
