//
//  Monday.h
//  Agenda 2
//
//  Created by Lee Hamilton on 11/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UITextView;
@interface Day : UIViewController <UITextViewDelegate>{
    IBOutlet UIScrollView *subScrollView;
    IBOutlet UILabel *math;
    IBOutlet UILabel *science;
    IBOutlet UILabel *social;
    IBOutlet UILabel *english;
    IBOutlet UILabel *language;
    IBOutlet UILabel *other;
    
    IBOutlet UITextView *mathBox;
    IBOutlet UITextView *scienceBox;
    IBOutlet UITextView *socialBox;
    IBOutlet UITextView *englishBox;
    IBOutlet UITextView *languageBox;
    IBOutlet UITextView *otherBox;
    
    UIView *inputAccView;    //Keyboard InputAccessoryView Outlet
    UITextView *currentTextView;

    NSMutableArray *textViewObjects;
    NSMutableArray *labelObjects;
    }

@property(nonatomic,retain) IBOutlet UIScrollView *subScrollView;
@property(nonatomic,retain) IBOutlet UILabel *math;
@property(nonatomic,retain) IBOutlet UILabel *science;
@property(nonatomic,retain) IBOutlet UILabel *social;
@property(nonatomic,retain) IBOutlet UILabel *english;
@property(nonatomic,retain) IBOutlet UILabel *language;
@property(nonatomic,retain) IBOutlet UILabel *other;

@property(nonatomic,retain)IBOutlet UITextView *mathBox;
@property(nonatomic,retain)IBOutlet UITextView *scienceBox;
@property(nonatomic,retain)IBOutlet UITextView *socialBox;
@property(nonatomic,retain)IBOutlet UITextView *englishBox;
@property(nonatomic,retain)IBOutlet UITextView *languageBox;
@property(nonatomic,retain)IBOutlet UITextView *otherBox;

@property(nonatomic,retain) NSMutableArray *textViewObjects;
@property(nonatomic,retain) NSMutableArray *labelObjects;

//Keyoard Input Accessory View Properties
@property(nonatomic,retain) UIView *inputAccView;

-(IBAction)endEdit:(id)sender;

@end
