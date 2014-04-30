//
//  SchedualTableViewController.m
//  Agenda 2
//
//  Created by Lee Hamilton on 12/7/11.
//  Copyright 2011 Lee Hamilton. All rights reserved.
//

#import "SchedualTableViewController.h"
#import "ScheduleClassDetails.h"
#import "Agenda_2AppDelegate.h"

@implementation SchedualTableViewController
@synthesize schedualArray, myTableView;
@synthesize schedualClassDetails, addModalView;
@synthesize aclassNameString,aclassPeriodString,aclassTeacherString,aclassLocationString;

-(void)setClassName:(NSString *)className withLocation:(NSString *)classLocation withPeriod:(NSString *)classPeriod andTeacher:(NSString *)teacherName{
    aclassNameString = className;
    aclassLocationString = classLocation;
    aclassPeriodString = classPeriod;
    aclassTeacherString = teacherName;
}

-(void)insertItemToTable{
    [scheduleDetails addObject:[NSArray arrayWithObjects:aclassNameString,aclassLocationString,aclassPeriodString,aclassTeacherString, nil]];
    [schedualArray addObject:aclassNameString];
    [myTableView reloadData];
    [self zsaveAllData:nil];
}

-(void)addItemToToolbar{
    if (addModalView == nil) {
        addModalView = [[AddModalView alloc]init];
    }
    [addModalView setDelegate:self];
    [self presentModalViewController:addModalView animated:YES];
}

-(void)zsaveAllData:(NSNotification *)notification{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *detailsPath = [NSString stringWithFormat:@"%@/classDetails.plist", [paths objectAtIndex:0]];
    NSString *tablePath = [NSString stringWithFormat:@"%@/classTable.plist",[paths objectAtIndex:0]];
    
    @try {
        [scheduleDetails writeToFile:detailsPath atomically:YES];
        [schedualArray writeToFile:tablePath atomically:YES];
        NSLog(@"Saving data successful!");
    }
    @catch (NSException *e) {
        NSLog(@"*******************");
        NSLog(@"*** ERROR: %@", e);
        NSLog(@"*******************");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"SCHEDULE ERROR" message:@"An error occured while saving. Please try again." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }

}

-(void)loadData{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *detailsPath = [NSString stringWithFormat:@"%@/classDetails.plist", [paths objectAtIndex:0]];
    NSString *tablePath = [NSString stringWithFormat:@"%@/classTable.plist",[paths objectAtIndex:0]];
    
    @try {
        [scheduleDetails addObjectsFromArray:[NSMutableArray arrayWithContentsOfFile:detailsPath]];
        [schedualArray addObjectsFromArray:[NSMutableArray arrayWithContentsOfFile:tablePath]];
        [myTableView reloadData];
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
        schedualArray = [[NSMutableArray alloc]init];
        scheduleDetails = [[NSMutableArray alloc]init];
    }
    return self;
}

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItemToToolbar)];
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zsaveAllData:) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(insertItemToTable) name:@"ScheduleDonePressed" object:nil];
    
    [self loadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.navigationItem.rightBarButtonItem = nil;
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
    return [self.schedualArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    [cell.textLabel setText:[schedualArray objectAtIndex:[indexPath row]]];
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
	  //add code here to delete specific class assignment data from files somehow
        
        //Loop through every file starting with a number, load the contents into an array, and delete the selected rows
        
        NSMutableArray *matches = [[NSMutableArray alloc]init];
        NSFileManager *manager = [NSFileManager defaultManager];
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
        
        NSString *item;
        NSArray *contents = [manager contentsOfDirectoryAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] error:nil];
        for (item in contents)
        {
            if ([[item pathExtension]isEqualToString:@"plist"])
            {
                if ([formatter numberFromString:[item substringToIndex:1]] != nil) {
                    [matches addObject:item];
                }
                
            }
        }
        NSLog(@"Array: %@",matches);
        if (matches != NULL || matches != nil){
            for (int x = 0; x < [matches count]; x++) { // [matches objectAtIndex:x] = the current file
                
                //Start of getting file contents
                
                NSMutableArray *fileContents = [NSMutableArray arrayWithContentsOfFile:[matches objectAtIndex:x]];
                [[fileContents objectAtIndex:0] removeObjectAtIndex:[indexPath row]]; //Monday
                [[fileContents objectAtIndex:1] removeObjectAtIndex:[indexPath row]]; //Tuesday
                [[fileContents objectAtIndex:2] removeObjectAtIndex:[indexPath row]]; //Wednesday
                [[fileContents objectAtIndex:3] removeObjectAtIndex:[indexPath row]]; //Thursday
                [[fileContents objectAtIndex:4] removeObjectAtIndex:[indexPath row]]; //Friday
                [[fileContents objectAtIndex:5] removeObjectAtIndex:[indexPath row]]; //Other 
                
                //End of getting file contents
                
                
                
            }
            
        }
        [formatter release];
        [matches release];
        
        //================= END LOAD FILE ==================================
        [schedualArray removeObjectAtIndex:[indexPath row]];
        NSLog(@"schedualArray: %@",schedualArray);
        [scheduleDetails removeObjectAtIndex:[indexPath row]];
        NSLog(@"scheduleDetails: %@", scheduleDetails);
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self zsaveAllData:nil];
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
    
     ScheduleClassDetails *detailViewController = [[ScheduleClassDetails alloc] initWithNibName:@"ScheduleClassDetails" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     detailViewController.title = [NSString stringWithFormat:@"%@", [schedualArray objectAtIndex:[indexPath row]]];
     [self.navigationController pushViewController:detailViewController animated:YES];
     detailViewController.className.text = detailViewController.title;
     NSLog(@"\n%@\n",[scheduleDetails objectAtIndex:indexPath.row]);
     detailViewController.classLocation.text = [[scheduleDetails objectAtIndex:indexPath.row] objectAtIndex:1];
     detailViewController.classPeriod.text = [[scheduleDetails objectAtIndex:indexPath.row] objectAtIndex:2];
     detailViewController.teacherName.text = [[scheduleDetails objectAtIndex:indexPath.row] objectAtIndex:3];
     [detailViewController release];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //self.navigationItem.rightBarButtonItem = nil;
    [schedualClassDetails release];
    [super dealloc];
}

@end
