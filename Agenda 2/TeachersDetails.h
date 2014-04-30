//
//  TeachersDetails.h
//  Agenda 2
//
//  Created by Lee Hamilton on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeachersDetails : UIViewController{
    IBOutlet UILabel *lTeacherName;
    IBOutlet UILabel *lTeacherRoom;
    IBOutlet UILabel *lTeacherEmail;
    IBOutlet UILabel *lTeacherPhone;
    IBOutlet UILabel *lTeacherWeb;
}
@property(nonatomic,retain) IBOutlet UILabel *lTeacherName;
@property(nonatomic,retain) IBOutlet UILabel *lTeacherRoom;
@property(nonatomic,retain) IBOutlet UILabel *lTeacherEmail;
@property(nonatomic,retain) IBOutlet UILabel *lTeacherPhone;
@property(nonatomic,retain) IBOutlet UILabel *lTeacherWeb;

@end
