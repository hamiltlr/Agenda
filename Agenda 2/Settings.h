//
//  Settings.h
//  Agenda 2
//
//  Created by Lee Hamilton on 2/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Settings : UIViewController <UIActionSheetDelegate>{
    IBOutlet UITextField *fontSize;
}

@property(nonatomic,retain) IBOutlet UITextField *fontSize;

-(IBAction)clearData:(id)sender;
-(IBAction)closeKeyboardAndSave:(id)sender;

@end
