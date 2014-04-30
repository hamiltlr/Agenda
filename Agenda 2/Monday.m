//
//  Monday.m
//  Agenda 2
//
//  Created by Lee Hamilton on 11/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Monday.h"

@class Agenda_2ViewController;

@implementation Monday

@synthesize subScrollView, math,science,social,english,language,other;
@synthesize mathBox,scienceBox,socialBox,englishBox,languageBox,otherBox;
@synthesize inputAccView;
@synthesize textViewObjects,labelObjects;


-(void)createInputAccessoryView{
    inputAccView = [[UIView alloc]initWithFrame:CGRectMake(10.0, 0.0, [[UIScreen mainScreen] bounds].size.width, 40.0)]; //was 310
    
	UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0.0, 0.0, 320.0, 40.0)];
    UIBarButtonItem *doneBttn = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(endEdit:)];

    [toolbar setItems:[NSArray arrayWithObject:doneBttn]];
    [inputAccView addSubview:toolbar];
	
    [toolbar release];
    [doneBttn release];
}
 
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    currentTextView = textView;
    [textView setInputAccessoryView:inputAccView];
    return YES;
}

-(IBAction)endEdit:(id)sender{
    [currentTextView resignFirstResponder];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        textViewObjects = [[NSMutableArray alloc]init];
        labelObjects = [[NSMutableArray alloc]init];
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
    
    textViewObjects = [[NSMutableArray alloc]init];
    labelObjects = [[NSMutableArray alloc]init];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *tablePath = [NSString stringWithFormat:@"%@/classTable.plist",[paths objectAtIndex:0]];
    NSArray *classes = [NSArray arrayWithContentsOfFile:tablePath];
    
    NSLog(@"%@",classes);

        for (int x = 0; x<[classes count];x++){
            NSLog(@"||||||||||||||||||||||||||||||||||||||||||| %i",x);
            
            UITextView *tmpTView = [[UITextView alloc]initWithFrame:CGRectMake(25, (20 + (110*x) + (43*x)), 280, 110)];
            [tmpTView setFont:[UIFont fontWithName:@"System" size:17.0]];
            
            UILabel *tmpLbl = [[UILabel alloc]init];
            tmpLbl.text = [classes objectAtIndex:x];
            tmpLbl.backgroundColor = [UIColor clearColor];

            [tmpLbl setTextAlignment:UITextAlignmentRight];
            tmpLbl.transform = CGAffineTransformMakeRotation(-3.14159265/2);
            tmpLbl.frame = CGRectMake(1, (20 + (110*x) + (43*x)), 21, 110);
            
            [textViewObjects addObject:tmpTView];
            
            [labelObjects addObject:tmpLbl];
            NSLog(@"[labelObjects objectAtIndex:%i] == %@",x,[labelObjects objectAtIndex:x]);
            [tmpTView release];
            [tmpLbl release];
            [self.subScrollView addSubview:[textViewObjects objectAtIndex:x]];
            [self.subScrollView addSubview:[labelObjects objectAtIndex:x]];
    }
    
    NSLog(@"%i",(153*[textViewObjects count]));
    
    
    [self.subScrollView setContentSize:CGSizeMake(320, (153*[textViewObjects count]))];
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

-(void)dealloc{
    [super dealloc];
    [subScrollView release];
    [math release];
    [science release];
    [social release];
    [english release];
    [language release];
    [other release];
    [mathBox release];
    [scienceBox release];
    [socialBox release];
    [englishBox release];
    [languageBox release];
    [otherBox release];
    [inputAccView release];
    [textViewObjects release];
    [labelObjects release];
}

@end
