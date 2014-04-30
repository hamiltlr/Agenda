//
//  Settings.m
//  Agenda 2
//
//  Created by Lee Hamilton on 2/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Settings.h"

@implementation Settings
@synthesize fontSize;

-(IBAction)closeKeyboardAndSave:(id)sender{
    [sender resignFirstResponder];
    if ([fontSize.text isEqualToString:@""]) {
        fontSize.text = @"17";
    }
    if ([fontSize.text floatValue] <= 8.0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"You can only input numbers less than 8 into this field" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        [fontSize isFirstResponder];
    }else{
        fontSize.text = [NSString stringWithFormat:@"%f",[fontSize.text floatValue]];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *prefsPath = [NSString stringWithFormat:@"%@/prefs.plist", [paths objectAtIndex:0]];
        NSArray *tmp = [NSArray arrayWithObject:fontSize.text];
        [tmp writeToFile:prefsPath atomically:YES];
    }
}

-(IBAction)clearData:(id)sender{
    NSLog(@"test");
    UIActionSheet *action = [[UIActionSheet alloc]
                                        initWithTitle:@"WARNING! THIS WILL PERMANENTLY DELETE ALL ASSIGNMENTS"
                                        delegate:self
                                        cancelButtonTitle:@"Cancel"
                                        destructiveButtonTitle:@"DELETE"
                                        otherButtonTitles:nil, nil];
    [action setTag:1];
    [action showInView:[UIApplication sharedApplication].keyWindow];
    [action release];
}

-(void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex != [actionSheet cancelButtonIndex]) {
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
            for (int x = 0; x < [matches count]; x++) {
                NSLog(@"Deleting file %@",[matches objectAtIndex:x]);
                [manager removeItemAtPath:[matches objectAtIndex:x] error:nil];
            }
        }
        [formatter release];
        [matches release];
    }
}

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
    //stuff here
}

-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"Setting up the arrays");
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *prefsPath = [NSString stringWithFormat:@"%@/prefs.plist", [paths objectAtIndex:0]];
    NSArray *prefs = [NSArray arrayWithContentsOfFile:prefsPath];
    NSLog(@"Setting the fontSize.text property");
    fontSize.text = [prefs objectAtIndex:0];
    NSLog(@"Releasing the objects");
    //[paths release];
    //[prefsPath release];
    //[prefs release];
    NSLog(@"Objects released");
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
