//
//  AddModalView.h
//  Agenda 2
//
//  Created by Lee Hamilton on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PassClassData <NSObject>
-(void)setClassName:(NSString *)className withLocation:(NSString *)classLocation withPeriod:(NSString *)classPeriod andTeacher:(NSString *)teacherName;
@required
@end

@interface AddModalView : UIViewController{
    IBOutlet UITextField *oClassName;
    IBOutlet UITextField *oClassLocation;
    IBOutlet UITextField *oClassPeriod;
    IBOutlet UITextField *oClassTeacher;
    
    NSString *classNameString;
    NSString *classLocationString;
    NSString *classPeriodString;
    NSString *classTeacherString;
    
    id <PassClassData> delegate;
}


-(IBAction)donePressed:(id)sender;
-(IBAction)cancelPressed:(id)sender;

@property(nonatomic,retain) IBOutlet UITextField *oClassName;
@property(nonatomic,retain) IBOutlet UITextField *oClassLocation;
@property(nonatomic,retain) IBOutlet UITextField *oClassPeriod;
@property(nonatomic,retain) IBOutlet UITextField *oClassTeacher;

@property(copy) NSString *classNameString;
@property(copy) NSString *classLocationString;
@property(copy) NSString *classPeriodString;
@property(copy) NSString *classTeacherString;

@property(retain) id delegate;


@end
