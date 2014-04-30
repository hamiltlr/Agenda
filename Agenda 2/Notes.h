//
//  Notes.h
//  Agenda 2
//
//  Created by Lee Hamilton on 12/5/11.
//  Copyright 2011 Lee Hamilton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MFMessageComposeViewController.h>

@class UITextView;
@interface Notes : UIViewController <UITextViewDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>{
    IBOutlet UITextView *notesText;
    UIView *inputAccView2;
}

@property(nonatomic,retain)IBOutlet UITextView *notesText;
@property(nonatomic,retain) UIView *inputAccView2;

-(IBAction)endEdit:(id)sender;

-(IBAction)emailNotes:(id)sender;
-(IBAction)tweetNotes:(id)sender;
-(IBAction)facebookNotes:(id)sender;


@end
