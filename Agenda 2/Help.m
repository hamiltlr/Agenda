//
//  Help.m
//  Agenda 2
//
//  Created by Lee Hamilton on 12/10/11.
//  Copyright 2011 Lee Hamilton. All rights reserved.
//

#import "Help.h"

@implementation Help

-(IBAction)bugReport:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:?to=leestechwebsite@gmail.com&sbject=AgendaBugReport"]];
}

-(IBAction)emailMe:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:?to=leestechwebsite@gmail.com&sbject=Agenda%20App%20Support"]];
}

-(IBAction)visitWebsite:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://lhamil64.wordpress.com"]];
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
