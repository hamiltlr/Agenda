//
//  AddModalView.m
//  Agenda 2
//
//  Created by Lee Hamilton on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddModalView.h"

@implementation AddModalView
@synthesize oClassName,oClassLocation,oClassPeriod,oClassTeacher,classNameString,classPeriodString,classTeacherString,classLocationString,delegate;

-(IBAction)donePressed:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ScheduleDonePressed" object:self];
}

-(IBAction)cancelPressed:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    oClassName.text=@"";
    oClassLocation.text=@"";
    oClassPeriod.text=@"";
    oClassTeacher.text=@"";
}

- (void) viewWillDisappear:(BOOL) animated
{
    [[self delegate] setClassName:oClassName.text withLocation:oClassLocation.text withPeriod:oClassPeriod.text andTeacher:oClassTeacher.text];
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
    // Do any additional setup after loading the view from its nib.
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
