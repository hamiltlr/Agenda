//
//  SchedualTableViewController.h
//  Agenda 2
//
//  Created by Lee Hamilton on 12/7/11.
//  Copyright 2011 Lee Hamilton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddModalView.h"

@class ScheduleClassDetails;
@interface SchedualTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, PassClassData>{
    IBOutlet UITableView *myTableView;
    NSMutableArray *schedualArray;
    NSMutableArray *scheduleDetails;
    ScheduleClassDetails *schedualClassDetails;
    AddModalView *addModalView;
    
    NSString *aclassNameString;
    NSString *aclassLocationString;
    NSString *aclassPeriodString;
    NSString *aclassTeacherString;
}
@property(nonatomic,retain) IBOutlet UITableView *myTableView;
@property(copy) NSMutableArray *schedualArray;
@property(nonatomic,retain) ScheduleClassDetails *schedualClassDetails;
@property(nonatomic,retain) AddModalView *addModalView;

@property(copy) NSString *aclassNameString;
@property(copy) NSString *aclassLocationString;
@property(copy) NSString *aclassPeriodString;
@property(copy) NSString *aclassTeacherString;

-(void)zsaveAllData:(NSNotification *)notification;
-(void)loadData;
-(void)addItemToToolbar;
-(void)insertItemToTable;

@end
