//
//  Agenda_2ViewController.h
//  Agenda 2
//
//  Created by Lee Hamilton on 10/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Day.h"

@interface Agenda_2ViewController : UIViewController <UIScrollViewDelegate> { //<UIScrollViewDelegate/*, UINavigationBarDelegate*/>{
    BOOL saving;
	BOOL loading;
    BOOL keyboardOpen;
    int week;
    int displayedYear;
    int currentPage;
    float fontSize;
	
    NSString *titlebarDay;
    NSMutableArray *textViewObjects;
    NSMutableArray *labelObjects;
        
    IBOutlet UIScrollView *scrollView;
    IBOutlet UINavigationBar *titleBar;
    
    /*Day *monObj;
    Tuesday *tuesObj;
    Wednesday *wedObj;
    Thursday *thursObj;
    Friday *friObj;
    Other *otherObj;*/
    
    NSMutableArray *days;
}

@property(nonatomic,retain) UIScrollView *scrollView;
@property(nonatomic,retain) UINavigationBar *titleBar;
@property(nonatomic,retain) NSMutableArray *textViewObjects;
@property(nonatomic,retain) NSMutableArray *labelObjects;

-(NSString *)getDates:(int)arg;
-(void)saveAllData:(NSNotification *)notification;
-(void)loadData:(NSString *)week:(NSString *)year;
-(void)keyboardDidShow;
-(void)keyboardDidHide;
-(void)checkKeyboardStatus;
-(IBAction)prevWeek:(id)sender;
-(IBAction)nextWeek:(id)sender;

@end
