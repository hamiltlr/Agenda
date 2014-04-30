//
//  QuickLinksTableViewController.m
//  Agenda 2
//
//  Created by Lee Hamilton on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QuickLinksTableViewController.h"
#import "QuickLinksDetails.h"
#import "Agenda_2AppDelegate.h"

@implementation QuickLinksTableViewController

@synthesize quickLinkNamesArray, quickLinkURLs, quickLinksDetails, quickLinkName, quickLinkURL, myTableView;

-(void)saveAllData:(NSNotification *)notification{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *detailsPath = [NSString stringWithFormat:@"%@/quickLinkURLs.plist", [paths objectAtIndex:0]];
    NSString *tablePath = [NSString stringWithFormat:@"%@/quickLinkNamesArray.plist",[paths objectAtIndex:0]];
    
    @try {
        [quickLinkURLs writeToFile:detailsPath atomically:YES];
        [quickLinkNamesArray writeToFile:tablePath atomically:YES];
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
    NSString *detailsPath = [NSString stringWithFormat:@"%@/quickLinkURLs.plist", [paths objectAtIndex:0]];
    NSString *tablePath = [NSString stringWithFormat:@"%@/quickLinkNamesArray.plist",[paths objectAtIndex:0]];
    
    @try {
        [quickLinkURLs addObjectsFromArray:[NSMutableArray arrayWithContentsOfFile:detailsPath]];
        [quickLinkNamesArray addObjectsFromArray:[NSMutableArray arrayWithContentsOfFile:tablePath]];
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
-(void)addItemToToolbar{
    UIAlertView *addAlert = [[UIAlertView alloc]initWithTitle:@"Add a Link" message:@"\n\n\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    UITextField *linkName = [[UITextField alloc]initWithFrame:CGRectMake(12.0, 50.0, 260.0, 25.0)];
    [linkName setBackgroundColor:[UIColor whiteColor]];
    [linkName setPlaceholder:@"Link Name"];
    [linkName setTag:701];
    [addAlert addSubview:linkName];
    
    UITextField *linkURL = [[UITextField alloc]initWithFrame:CGRectMake(12.0, 85.0, 260.0, 25.0)];
    [linkURL setBackgroundColor:[UIColor whiteColor]];
    [linkURL setPlaceholder:@"Link URL"];
    [linkURL setTag:702];
    [linkURL setKeyboardType:UIKeyboardTypeURL];
    [linkURL setAutocorrectionType:UITextAutocorrectionTypeNo];
    [linkURL setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [addAlert addSubview:linkURL];
    
    //[addAlert setTransform:CGAffineTransformMakeTranslation(0.0, 110.0)];
    [addAlert show];
    [addAlert release];
    [linkName becomeFirstResponder];
    
    [linkName release];
    [linkURL release];
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if (buttonIndex == 0)
    {
        //User pressed the Cancel button
        NSLog(@"User pressed the Cancel button");
        return;
    }
    else
    {
        //User pressed the Add button
        NSLog(@"User pressed the Add button");
        UITextField *nameTmp = (UITextField *)[alertView viewWithTag:701];
        UITextField *urlTmp  = (UITextField *)[alertView viewWithTag:702];
        NSLog(@"%@",nameTmp.text);
        NSLog(@"%@",urlTmp.text);
        NSString *subUrl = [urlTmp.text substringToIndex:7];
        //NSString *subUrl2 = [urlTmp.text substringToIndex:8];
        if ([subUrl isEqualToString:@"http://"] || [subUrl isEqualToString:@"https:/"]) {
            [quickLinkNamesArray addObject:nameTmp.text];
            [quickLinkURLs addObject:urlTmp.text];
            NSLog(@"added objects to the arrays");
            [myTableView reloadData];
            NSLog(@"reloaded data");
        }else{
            NSLog(@"User didn't include http. Adding to URL");
            [quickLinkNamesArray addObject:nameTmp.text];
            [quickLinkURLs addObject:[NSString stringWithFormat:@"http://%@",urlTmp.text]];
            NSLog(@"added objects to the arrays");
            [myTableView reloadData];
            NSLog(@"reloaded data");
            
        }
    }
}

-(void)insertItemToTable{
    
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        //Custom init
        quickLinkNamesArray = [[NSMutableArray alloc]init];
        quickLinkURLs = [[NSMutableArray alloc]init];
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
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItemToToolbar)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveAllData:) name:UIApplicationWillResignActiveNotification object:nil];
    
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

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //self.navigationItem.rightBarButtonItem = nil;
    [quickLinksDetails release];
    [super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [quickLinkNamesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    [cell.textLabel setText:[quickLinkNamesArray objectAtIndex:[indexPath row]]];
    
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
        [quickLinkNamesArray removeObjectAtIndex:indexPath.row];
        [quickLinkURLs removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}


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
     QuickLinksDetails *detailViewController = [[QuickLinksDetails alloc] initWithNibName:@"QuickLinksDetails" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
    detailViewController.title = [NSString stringWithFormat:@"%@", [quickLinkNamesArray objectAtIndex:[indexPath row]]];
    [self.navigationController pushViewController:detailViewController animated:YES];
    if ([NSURL URLWithString:[quickLinkURLs objectAtIndex:indexPath.row]] != NULL) {
        [detailViewController.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[quickLinkURLs objectAtIndex:indexPath.row]]]];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"There was a problem connecting to the page. Check your internet connection and try again" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    
    if ([detailViewController.webView canGoBack]) {
        detailViewController.back.enabled = TRUE;
    }else{
        detailViewController.back.enabled = FALSE;
    }
    if ([detailViewController.webView canGoForward]) {
        detailViewController.forward.enabled = TRUE;
    }else{
        detailViewController.forward.enabled = FALSE;
    }
    [detailViewController release];
}

@end
