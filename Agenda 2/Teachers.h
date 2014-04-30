//
//  Teachers.h
//  Agenda 2
//
//  Created by Lee Hamilton on 12/5/11.
//  Copyright 2011 Lee Hamilton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddTeacher.h"

@class TeachersDetails;
@interface Teachers : UITableViewController <UITableViewDelegate, UITableViewDataSource, PassTeacherData>{
    IBOutlet UITableView *teachersTableView;
    NSMutableArray *teachersArray;
    NSMutableArray *teachersDetailsArray;
    TeachersDetails *teacherClassDetails;
    AddTeacher *addTeacherView;
    
    NSString *tName;
    NSString *tRoom;
    NSString *tEmail;
    NSString *tPhone;
    NSString *tWeb;
}

@property(nonatomic,retain) IBOutlet UITableView *teachersTableView;

@property(copy) NSMutableArray *teachersArray;
@property(nonatomic,retain) TeachersDetails *teacherClassDetails;
@property(nonatomic,retain) AddTeacher *addTeacherView;

@property(copy) NSString *tName;
@property(copy) NSString *tRoom;
@property(copy) NSString *tEmail;
@property(copy) NSString *tPhone;
@property(copy) NSString *tWeb;


-(void)saveAllData:(NSNotification *)notification;
-(void)loadData;
-(void)addItemToToolbar;
-(void)insertItemToTable;
    
@end
