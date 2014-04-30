//
//  AddTeacher.h
//  Agenda 2
//
//  Created by Lee Hamilton on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PassTeacherData <NSObject>
-(void)setTeacherName:(NSString *)theTeacherName withRoom:(NSString *)teacherRoom withEmail:(NSString *)teacherEmail withPhone:(NSString *)teacherPhone andWeb:(NSString *)teacherWeb;
@required
@end

@interface AddTeacher : UIViewController{
    IBOutlet UITextField *oTeacherName;
    IBOutlet UITextField *oTeacherRoom;
    IBOutlet UITextField *oTeacherEmail;
    IBOutlet UITextField *oTeacherPhone;
    IBOutlet UITextField *oTeacherWeb;
    
    NSString *teacherNameString;
    NSString *teacherRoomString;
    NSString *teacherEmailString;
    NSString *teacherPhoneString;
    NSString *teacherWebString;
    
    id <PassTeacherData> delegate;
}

-(IBAction)donePressed:(id)sender;
-(IBAction)cancelPressed:(id)sender;

@property(nonatomic,retain) IBOutlet UITextField *oTeacherName;
@property(nonatomic,retain) IBOutlet UITextField *oTeacherRoom;
@property(nonatomic,retain) IBOutlet UITextField *oTeacherEmail;
@property(nonatomic,retain) IBOutlet UITextField *oTeacherPhone;
@property(nonatomic,retain) IBOutlet UITextField *oTeacherWeb;

@property(copy) NSString *teacherNameString;
@property(copy) NSString *teacherRoomString;
@property(copy) NSString *teacherEmailString;
@property(copy) NSString *teacherPhoneString;
@property(copy) NSString *teacherWebString;

@property(retain) id delegate;

@end
