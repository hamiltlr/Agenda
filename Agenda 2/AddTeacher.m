//
//  AddTeacher.m
//  Agenda 2
//
//  Created by Lee Hamilton on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddTeacher.h"

@implementation AddTeacher
@synthesize oTeacherName,oTeacherRoom,oTeacherEmail,oTeacherPhone,oTeacherWeb,teacherNameString,teacherRoomString,teacherEmailString,teacherPhoneString,teacherWebString,delegate;

-(IBAction)donePressed:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TeacherDonePressed" object:self];
}

-(IBAction)cancelPressed:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    oTeacherName.text = @"";
    oTeacherRoom.text = @"";
    oTeacherEmail.text = @"";
    oTeacherPhone.text = @"";
    oTeacherWeb.text = @"";
    
    teacherNameString = @"";
    teacherRoomString = @"";
    teacherEmailString = @"";
    teacherPhoneString = @"";
    teacherWebString = @"";
}

- (void) viewWillDisappear:(BOOL) animated
{
    [[self delegate] setTeacherName:oTeacherName.text withRoom:oTeacherRoom.text withEmail:oTeacherEmail.text withPhone:oTeacherPhone.text andWeb:oTeacherWeb.text];
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
