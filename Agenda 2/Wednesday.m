//
//  Wednesday.m
//  Agenda 2
//
//  Created by Lee Hamilton on 11/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Wednesday.h"

@implementation Wednesday

@synthesize subScrollView, math,science,social,english,language,other;
@synthesize mathBox,scienceBox,socialBox,englishBox,languageBox,otherBox;
@synthesize inputAccView;
@synthesize textViewObjects,labelObjects;

-(void)createInputAccessoryView{
    inputAccView = [[UIView alloc]initWithFrame:CGRectMake(10.0, 0.0, 310.0, 40.0)];
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0.0, 0.0, 320.0, 40.0)];
    UIBarButtonItem *doneBttn = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(endEdit:)];
    [toolbar setItems:[NSArray arrayWithObject:doneBttn]];
    [inputAccView addSubview:toolbar];
    [toolbar release];
    [doneBttn release];    
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    [textView setInputAccessoryView:inputAccView];
    return YES;
}

-(IBAction)endEdit:(id)sender{
    [mathBox resignFirstResponder];
    [scienceBox resignFirstResponder];
    [socialBox resignFirstResponder];
    [englishBox resignFirstResponder];
    [languageBox resignFirstResponder];
    [otherBox resignFirstResponder];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    //[self createInputAccessoryView];
    textViewObjects = [[NSMutableArray alloc]init];
    labelObjects = [[NSMutableArray alloc]init];
    
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
        //          tmpLbl.textColor = [UIColor colorWithRed:15.0 green:0.0 blue:133.0 alpha:100];
        [tmpLbl setTextAlignment:UITextAlignmentRight];
        tmpLbl.transform = CGAffineTransformMakeRotation(-3.14159265/2);
        tmpLbl.frame = CGRectMake(1, (20 + (110*x) + (43*x)), 21, 110);
        
        //NSLog(@"tmpTView == %@",tmpTView);
        [textViewObjects addObject:tmpTView];
        //NSLog(@"[textViewObjects objectAtIndex:%i] == %@",x,[textViewObjects objectAtIndex:x]);
        
        //NSLog(@"tmpLbl == %@",tmpLbl);
        [labelObjects addObject:tmpLbl];
        NSLog(@"[labelObjects objectAtIndex:%i] == %@",x,[labelObjects objectAtIndex:x]);
        [tmpTView release];
        [tmpLbl release];
        [self.subScrollView addSubview:[textViewObjects objectAtIndex:x]];
        [self.subScrollView addSubview:[labelObjects objectAtIndex:x]];
        
        //UITextView *tmp = [textViewObjects objectAtIndex:0];
        //tmp.text = @"test";
        //NSLog(@"[textViewObjects objectAtIndex:0] == %@",[[textViewObjects objectAtIndex:0] text]);
    }
    
    NSLog(@"%i",(153*[textViewObjects count]));
    
    
    [self.subScrollView setContentSize:CGSizeMake(320, (153*[textViewObjects count]))];    

    
    /*
    //ROTATE TEXT LABELS
    math.transform = CGAffineTransformMakeRotation(-3.14159/2);
    science.transform = CGAffineTransformMakeRotation(-3.14159/2);
    social.transform = CGAffineTransformMakeRotation(-3.14159/2);
    english.transform = CGAffineTransformMakeRotation(-3.14159/2);
    language.transform = CGAffineTransformMakeRotation(-3.14159/2);
    other.transform = CGAffineTransformMakeRotation(-3.14159/2);
    
    //Align labels with side of display
    math.frame = CGRectMake(1, 20, 21, 55);
    science.frame = CGRectMake(1, 173, 21, 76);
    social.frame = CGRectMake(1, 326, 21, 63);
    english.frame = CGRectMake(1, 480, 21, 75);
    language.frame = CGRectMake(1, 633, 21, 95);
    other.frame = CGRectMake(1, 780, 21, 60);
    
    //Adjust positioning of text boxes
    mathBox.transform = CGAffineTransformMakeTranslation(0, 15);
    scienceBox.transform = CGAffineTransformMakeTranslation(0, 16);
    socialBox.transform = CGAffineTransformMakeTranslation(0, 15);
    englishBox.transform = CGAffineTransformMakeTranslation(0, 17);
    languageBox.transform = CGAffineTransformMakeTranslation(0, 20);
    otherBox.transform = CGAffineTransformMakeTranslation(0, 13);*/
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
