//
//  ScheduleClassDetails.h
//  Agenda 2
//
//  Created by Lee Hamilton on 12/9/11.
//  Copyright 2011 Lee Hamilton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleClassDetails : UIViewController{
    IBOutlet UILabel *className;
    IBOutlet UILabel *teacherName;
    IBOutlet UILabel *classPeriod;
    IBOutlet UILabel *classLocation;
}

@property(nonatomic,retain) IBOutlet UILabel *className;
@property(nonatomic,retain) IBOutlet UILabel *teacherName;
@property(nonatomic,retain) IBOutlet UILabel *classPeriod;
@property(nonatomic,retain) IBOutlet UILabel *classLocation;

@end
