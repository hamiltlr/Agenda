//
//  Agenda_2ViewController.m
//  Agenda 2
//
//  Created by Lee Hamilton on 10/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Agenda_2ViewController.h"

@implementation Agenda_2ViewController
@synthesize scrollView, titleBar, textViewObjects, labelObjects;

-(IBAction)prevWeek:(id)sender{
    if (saving == YES || loading == YES){
		[self prevWeek:nil];
	}else{
		[self saveAllData:nil];
		NSLog(@"Prev week called.\nYear:%i\nWeek%i",displayedYear,week);
    if ((week-1)<1) {
        week = 52;
        displayedYear--;
    }else{
        week--;
    }
    titleBar.topItem.title = [NSString stringWithFormat:@"%@ - Week %i", titlebarDay, week];
    [self loadData:[NSString stringWithFormat:@"%i",week] : [NSString stringWithFormat:@"%i",displayedYear]];
	}
}

-(IBAction)nextWeek:(id)sender{
    if (saving == YES || loading == YES){
		[self nextWeek:nil];
	}else{
        [self saveAllData:nil];
		NSLog(@"Prev week called.\nYear:%i\nWeek%i",displayedYear,week);
    if ((week+1)>52) {
        week = 1;
        displayedYear++;
    }else{
        week++;
    }
    titleBar.topItem.title = [NSString stringWithFormat:@"%@ - Week %i", titlebarDay, week];
    [self loadData:[NSString stringWithFormat:@"%i",week] : [NSString stringWithFormat:@"%i",displayedYear]];
	}
}

-(NSString *)getDates:(int)arg{   //arg: 1 = day of week.
                                  //     2 = week number
                                  //     3 = year
    
    NSDate *date = [NSDate date];
    NSDateFormatter *weekFormatter = [[NSDateFormatter alloc] init];
    
    if (arg == 1) {
        
        [weekFormatter setDateFormat:@"EEEE"];
        NSString *dayString = [weekFormatter stringFromDate:[NSDate date]];
        [weekFormatter release];
        NSLog(@"%@",dayString);c
        return dayString;
    
    }else if (arg == 2){
        
        [weekFormatter setDateFormat:@"w"];
        NSString *weekDateString = [weekFormatter stringFromDate:date];
        [weekFormatter release];
        return weekDateString;
        
    }else if (arg == 3){
        
        [weekFormatter setDateFormat:@"yyyy"];
        NSString *year = [weekFormatter stringFromDate:date];
        [weekFormatter release];
        return year;
    }
    else{
        [weekFormatter release];
        return @"ERROR";
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollViewVar {
    static NSInteger previousPage = 0;
    CGFloat pageWidth = scrollViewVar.frame.size.width;
    float fractionalPage = scrollViewVar.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    if (previousPage != page) {
        // Page has changed
        NSLog(@"Current page number: %i", page);
        switch (page) {
            case 0:
                titlebarDay = @"Monday";
                currentPage = page;
                break;
            case 1:
                titlebarDay = @"Tuesday";
                currentPage = page;
                break;
            case 2:
                titlebarDay = @"Wednesday";
                currentPage = page;                
                break;
            case 3:
                titlebarDay = @"Thursday";
                currentPage = page;                
                break;
            case 4:
                titlebarDay = @"Friday";
                currentPage = page;                
                break;
            case 5:
                titlebarDay = @"Other";
                currentPage = page;                
                break;
            default:
                titlebarDay = @"ERROR!";
                currentPage = 0;                
                break;
        }
        NSLog(@"Titlebar text 2: %@ - Week %i", titlebarDay, week); //DayOfWeek - Week#
        titleBar.topItem.title = [NSString stringWithFormat:@"%@ - Week %i", titlebarDay, week];
        previousPage = page;
    }     
}

-(void)saveAllData:(NSNotification *)notification{
    saving = YES;
    NSLog(@"<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
    NSLog(@"SAVE ALL DATA");
    @try {
    
    /*NSMutableArray *monArray = [[NSMutableArray alloc]init];
    NSMutableArray *tuesArray = [[NSMutableArray alloc]init];
    NSMutableArray *wedArray = [[NSMutableArray alloc]init];
    NSMutableArray *thursArray = [[NSMutableArray alloc]init];
    NSMutableArray *friArray = [[NSMutableArray alloc]init];
    NSMutableArray *otherArray = [[NSMutableArray alloc]init];*/
    
    NSMutableDictionary *monDict = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *tuesDict = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *wedDict = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *thursDict = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *friDict = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *otherDict = [[NSMutableDictionary alloc]init];    
        
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [NSString stringWithFormat:@"%@/%i-%@.plist", [paths objectAtIndex:0], week, [self getDates:3]];
    NSString *tablePath = [NSString stringWithFormat:@"%@/classTable.plist",[paths objectAtIndex:0]];
    NSArray *classes = [NSArray arrayWithContentsOfFile:tablePath];
    //NSString *prefsPath = [NSString stringWithFormat:@"%@/prefs.plist", [paths objectAtIndex:0]];
    
    NSLog(@"Loop start");
        
        for (int x=0; x<[classes count]; x++) {
            [monDict setObject:[[monObj.textViewObjects objectAtIndex:x] text] forKey:[classes objectAtIndex:x]];
            [tuesDict setObject:[[tuesObj.textViewObjects objectAtIndex:x] text] forKey:[classes objectAtIndex:x]];
            [wedDict setObject:[[wedObj.textViewObjects objectAtIndex:x] text] forKey:[classes objectAtIndex:x]];
            [thursDict setObject:[[thursObj.textViewObjects objectAtIndex:x] text] forKey:[classes objectAtIndex:x]];
            [friDict setObject:[[friObj.textViewObjects objectAtIndex:x] text] forKey:[classes objectAtIndex:x]];
            [otherDict setObject:[[otherObj.textViewObjects objectAtIndex:x] text] forKey:[classes objectAtIndex:x]];
        }
    /*    
    for(int x = 0; x <= [monObj.textViewObjects count]-1; x++){
        //NSLog(@"Monday");
        //NSLog(@"=======================================================");
        //NSLog(@"x == %i\nSetting up tmp variable",x);
        
		UITextView *tmp = [monObj.textViewObjects objectAtIndex:x];
        [monArray addObject:tmp.text];
        
        //NSLog(@"=======================================================");
	}

    for(int x = 0; x <= [tuesObj.textViewObjects count]-1; x++){
        //NSLog(@"Tuesday");
        //NSLog(@"=======================================================");
		
        //NSLog(@"x == %i\nSetting up tmp variable",x);
        UITextView *tmp = [tuesObj.textViewObjects objectAtIndex:x];
        [tuesArray addObject:tmp.text];
        //NSLog(@"=======================================================");
	}
    
    for(int x = 0; x <= [wedObj.textViewObjects count]-1; x++){
        //NSLog(@"Wednesday");        
        //NSLog(@"=======================================================");
		
        //NSLog(@"x == %i\nSetting up tmp variable",x);
        UITextView *tmp = [wedObj.textViewObjects objectAtIndex:x];
        [wedArray addObject:tmp.text];
        //NSLog(@"=======================================================");
	}
    
    for(int x = 0; x <= [thursObj.textViewObjects count]-1; x++){
        //NSLog(@"Thursday");
        //NSLog(@"=======================================================");
		
        //NSLog(@"x == %i\nSetting up tmp variable",x);
        UITextView *tmp = [thursObj.textViewObjects objectAtIndex:x];
        [thursArray addObject:tmp.text];

        //NSLog(@"=======================================================");
	}
    
    for(int x = 0; x <= [friObj.textViewObjects count]-1; x++){
        //NSLog(@"Friday");        
        //NSLog(@"=======================================================");
		
        //NSLog(@"x == %i\nSetting up tmp variable",x);
        UITextView *tmp = [friObj.textViewObjects objectAtIndex:x];
        [friArray addObject:tmp.text];

        //NSLog(@"=======================================================");
	}
    
    for(int x = 0; x <= [otherObj.textViewObjects count]-1; x++){
        //NSLog(@"Other");
        //NSLog(@"=======================================================");
        
        //NSLog(@"x == %i\nSetting up tmp variable",x);
        UITextView *tmp = [otherObj.textViewObjects objectAtIndex:x];
        [otherArray addObject:tmp.text];

        NSLog(@"=======================================================");
	}*/
    
    //NSMutableArray *dataArray = [[NSMutableArray alloc] initWithObjects:monArray,tuesArray,wedArray, thursArray, friArray, otherArray, nil];
    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithObjects:monDict,tuesDict,wedDict,thursDict,friDict,otherDict, nil];
    NSLog(@"SAVE dataArray: %@",dataArray);
    
    NSLog(@"%@",filePath);
    NSLog(@"dataArray writeToFile");
    [dataArray writeToFile:filePath atomically:YES];
    NSLog(@"Saving data successful!");
    
    [dataArray release];
    /*[monArray release];
    [tuesArray release];
    [wedArray release];
    [thursArray release];
    [friArray release];
    [otherArray release];*/
    }
    @catch (NSException *exception) {
        NSLog(@"******** ERROR *********");
        NSLog(@"%@", exception);
        NSLog(@"************************");
        //UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"VIEWCONTROLLER ERROR" message:@"An error occured while saving. Please try again." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
        //[alert show];
        //[alert release];
    }
    saving = NO;
}

-(void)loadData:(NSString *)localWeek:(NSString *)localYear{
    loading = YES;
	NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    NSLog(@"Loading data...");
    NSLog(@"Week: %@", localWeek);
    NSLog(@"Year: %@", localYear);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [NSString stringWithFormat:@"%@/%@-%@.plist", [paths objectAtIndex:0], localWeek, localYear];
    NSString *tablePath = [NSString stringWithFormat:@"%@/classTable.plist",[paths objectAtIndex:0]];
    NSArray *classes = [NSArray arrayWithContentsOfFile:tablePath];    
    NSLog(@"filePath: %@", filePath);
    
    @try {
    NSMutableArray *dataArray = [[NSMutableArray alloc]initWithContentsOfFile:filePath];
    NSLog(@"LOAD dataArray: %@",dataArray);
    
    for (int x=0; x<[classes count]; x++) {
        UITextView *tmp = [monObj.textViewObjects objectAtIndex:x];
        tmp.text = [[dataArray objectAtIndex:0] valueForKey:[classes objectAtIndex:x]];
        
        tmp = [tuesObj.textViewObjects objectAtIndex:x];
        tmp.text = [[dataArray objectAtIndex:1] valueForKey:[classes objectAtIndex:x]];
        
        tmp = [wedObj.textViewObjects objectAtIndex:x];
        tmp.text = [[dataArray objectAtIndex:2] valueForKey:[classes objectAtIndex:x]];
        
        tmp = [thursObj.textViewObjects objectAtIndex:x];
        tmp.text = [[dataArray objectAtIndex:3] valueForKey:[classes objectAtIndex:x]];
        
        tmp = [friObj.textViewObjects objectAtIndex:x];
        tmp.text = [[dataArray objectAtIndex:4] valueForKey:[classes objectAtIndex:x]];
        
        tmp = [otherObj.textViewObjects objectAtIndex:x];
        tmp.text = [[dataArray objectAtIndex:5] valueForKey:[classes objectAtIndex:x]];
    }    
        
/*        
        //Monday
        for(int x = 0; x <= [monObj.textViewObjects count]-1; x++){
            UITextView *tmp = [monObj.textViewObjects objectAtIndex:x];
            
            [tmp setFont:[UIFont fontWithName:@"ArialMT" size:17.0]];
            //NSLog(@"Setting text of tmp var");
            //tmp.text = [[dataArray objectAtIndex:0] objectAtIndex:x];
            //NSLog(@"Text set. Releasing..");
            //[tmp release];
        }
        
        //Tuesday
        for(int x = 0; x <= [tuesObj.textViewObjects count]-1; x++){
            UITextView *tmp = [tuesObj.textViewObjects objectAtIndex:x];
            [tmp setFont:[UIFont fontWithName:@"ArialMT" size:17.0]];
            NSLog(@"Setting text of tmp var");
            tmp.text = [[dataArray objectAtIndex:1] objectAtIndex:x];
            NSLog(@"Text set. Releasing..");
            //[tmp release];
        }
        
        //Wednesday
        for(int x = 0; x <= [wedObj.textViewObjects count]-1; x++){
            UITextView *tmp = [wedObj.textViewObjects objectAtIndex:x];
            [tmp setFont:[UIFont fontWithName:@"ArialMT" size:17.0]];
            tmp.text = [[dataArray objectAtIndex:2] objectAtIndex:x];
            //[tmp release];
        }
        
        //Thursday
        for(int x = 0; x <= [thursObj.textViewObjects count]-1; x++){
            UITextView *tmp = [thursObj.textViewObjects objectAtIndex:x];
            [tmp setFont:[UIFont fontWithName:@"ArialMT" size:17.0]];
            tmp.text = [[dataArray objectAtIndex:3] objectAtIndex:x];
            //[tmp release];
        }
        
        //Friday
        for(int x = 0; x <= [friObj.textViewObjects count]-1; x++){
            UITextView *tmp = [friObj.textViewObjects objectAtIndex:x];
            [tmp setFont:[UIFont fontWithName:@"ArialMT" size:17.0]];
            tmp.text = [[dataArray objectAtIndex:4] objectAtIndex:x];
            //[tmp release];
        }
        
        //Other
        for(int x = 0; x <= [otherObj.textViewObjects count]-1; x++){
            UITextView *tmp = [otherObj.textViewObjects objectAtIndex:x];
            [tmp setFont:[UIFont fontWithName:@"ArialMT" size:17.0]];
            tmp.text = [[dataArray objectAtIndex:5] objectAtIndex:x];
            //[tmp release];
        }*/
    
    /*tuesObj.scienceBox.text = [[dataArray objectAtIndex:1] objectAtIndex:1];
    tuesObj.socialBox.text = [[dataArray objectAtIndex:1] objectAtIndex:2];
    tuesObj.englishBox.text = [[dataArray objectAtIndex:1] objectAtIndex:3];
    tuesObj.languageBox.text = [[dataArray objectAtIndex:1] objectAtIndex:4];
    tuesObj.otherBox.text = [[dataArray objectAtIndex:1] objectAtIndex:5];    
    
    wedObj.scienceBox.text = [[dataArray objectAtIndex:2] objectAtIndex:1];
    wedObj.socialBox.text = [[dataArray objectAtIndex:2] objectAtIndex:2];
    wedObj.englishBox.text = [[dataArray objectAtIndex:2] objectAtIndex:3];
    wedObj.languageBox.text = [[dataArray objectAtIndex:2] objectAtIndex:4];
    wedObj.otherBox.text = [[dataArray objectAtIndex:2] objectAtIndex:5];    
    
    thursObj.scienceBox.text = [[dataArray objectAtIndex:3] objectAtIndex:1];
    thursObj.socialBox.text = [[dataArray objectAtIndex:3] objectAtIndex:2];
    thursObj.englishBox.text = [[dataArray objectAtIndex:3] objectAtIndex:3];
    thursObj.languageBox.text = [[dataArray objectAtIndex:3] objectAtIndex:4];
    thursObj.otherBox.text = [[dataArray objectAtIndex:3] objectAtIndex:5];    
    
    friObj.scienceBox.text = [[dataArray objectAtIndex:4] objectAtIndex:1];
    friObj.socialBox.text = [[dataArray objectAtIndex:4] objectAtIndex:2];
    friObj.englishBox.text = [[dataArray objectAtIndex:4] objectAtIndex:3];
    friObj.languageBox.text = [[dataArray objectAtIndex:4] objectAtIndex:4];
    friObj.otherBox.text = [[dataArray objectAtIndex:4] objectAtIndex:5];    
    
    otherObj.scienceBox.text = [[dataArray objectAtIndex:5] objectAtIndex:1];
    otherObj.socialBox.text = [[dataArray objectAtIndex:5] objectAtIndex:2];
    otherObj.englishBox.text = [[dataArray objectAtIndex:5] objectAtIndex:3];
    otherObj.languageBox.text = [[dataArray objectAtIndex:5] objectAtIndex:4];
    otherObj.otherBox.text = [[dataArray objectAtIndex:5] objectAtIndex:5];    
    
    monObj.mathBox.text = [[dataArray objectAtIndex:0] objectAtIndex:0];
    tuesObj.mathBox.text = [[dataArray objectAtIndex:1] objectAtIndex:0];
    wedObj.mathBox.text = [[dataArray objectAtIndex:2] objectAtIndex:0];
    thursObj.mathBox.text = [[dataArray objectAtIndex:3] objectAtIndex:0];
    friObj.mathBox.text = [[dataArray objectAtIndex:4] objectAtIndex:0];
    otherObj.mathBox.text = [[dataArray objectAtIndex:5] objectAtIndex:0];*/

    [dataArray release];
    }
    @catch (NSException *exception) {
        NSLog(@"Error: %@",exception);
    }
	loading = NO;
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

-(void)keyboardDidShow{
    keyboardOpen = YES;
    NSLog(@"Keyboard did show!");
}

-(void)keyboardDidHide{
    keyboardOpen = NO;
    [self saveAllData:nil];
    NSLog(@"Keyboard did hide!");
}

-(void)checkKeyboardStatus{
    if (keyboardOpen == YES) {
        [self saveAllData:nil];
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSDate *today = [NSDate date];
    NSLog(@"Date: %@",today);
    week = [[self getDates:2] intValue];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkKeyboardStatus) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide) name:UIKeyboardDidHideNotification object:nil];
    
    scrollView.contentSize = CGSizeMake(1920, 367); //was 1920x367
        
    //CGRectMake: x, y, width, height
    monObj = [[Monday alloc]init];
    monObj.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-44);
    [scrollView addSubview:monObj.view];
    
    tuesObj = [[Tuesday alloc]init];
    tuesObj.view.frame = CGRectMake(320, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-44); //CGRectGetHeight(self.view.bounds)
    [scrollView addSubview:tuesObj.view];
    
    wedObj = [[Wednesday alloc]init];
    wedObj.view.frame = CGRectMake(640, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-44);
    [scrollView addSubview:wedObj.view];
    
    thursObj = [[Thursday alloc]init];
    thursObj.view.frame = CGRectMake(960, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-44);
    [scrollView addSubview:thursObj.view];
    
    friObj = [[Friday alloc]init];
    friObj.view.frame = CGRectMake(1280, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-44);
    [scrollView addSubview:friObj.view];
    
    otherObj = [[Other alloc]init];
    otherObj.view.frame = CGRectMake(1600, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-44);
    [scrollView addSubview:otherObj.view];
    
    //Setup variables with current week, year, and weekday
    displayedYear = [[self getDates:3] intValue];
    week=[[self getDates:2] intValue];
    titlebarDay = [self getDates:1];
    float tmp;
    
    if ([titlebarDay isEqualToString:@"Monday"]) {
        tmp = 0.0;
    }else if ([titlebarDay isEqualToString:@"Tuesday"]){
        tmp = 1.0;
    }else if ([titlebarDay isEqualToString:@"Wednesday"]){
        tmp = 2.0;
    }else if ([titlebarDay isEqualToString:@"Thursday"]){
        tmp = 3.0;
    }else if ([titlebarDay isEqualToString:@"Friday"]){
        tmp = 4.0;
    }else if ([titlebarDay isEqualToString:@"Saturday"]){
        tmp = 5.0;
        titlebarDay = @"Other";
    }else if ([titlebarDay isEqualToString:@"Sunday"]){
        //week--;
        tmp = 5.0;
        titlebarDay = @"Other";
    }else{
        tmp = -1.0; //An error occured somewhere
    }
    
    if (tmp || tmp != -1.0) {
        CGPoint scrollToDate = CGPointMake(scrollView.bounds.size.width*(tmp), 0);
        [scrollView setContentOffset:scrollToDate animated:YES];
    }
    NSLog(@"Titlebar text 1: %@ - Week %i", titlebarDay, week);
    titleBar.topItem.title = [NSString stringWithFormat:@"%@ - Week %i", titlebarDay, week];
    [self loadData:[NSString stringWithFormat:@"%i",week]:[NSString stringWithFormat:@"%i",displayedYear]];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSLog(@"didSelectItem: %d", item.tag);
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
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [scrollView release];
    [titleBar release];
    [monObj release];
    [tuesObj release];
    [wedObj release];
    [thursObj release];
    [friObj release];
    [otherObj release];
}

@end
