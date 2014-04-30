//
//  QuickLinksTableViewController.h
//  Agenda 2
//
//  Created by Lee Hamilton on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QuickLinksDetails;
@interface QuickLinksTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>{
    IBOutlet UITableView *myTableView;
    NSMutableArray *quickLinkNamesArray;
    NSMutableArray *quickLinkURLs;
    
    QuickLinksDetails *quickLinksDetails;    
    
    NSString *quickLinkName;
    NSString *quickLinkURL;
    
}

@property(nonatomic,retain) IBOutlet UITableView *myTableView;
@property(copy) NSMutableArray *quickLinkNamesArray;
@property(copy) NSMutableArray *quickLinkURLs;
@property(nonatomic,retain) QuickLinksDetails *quickLinksDetails;
@property(copy) NSString *quickLinkName;
@property(copy) NSString *quickLinkURL;

-(void)saveAllData:(NSNotification *)notification;
-(void)loadData;
-(void)addItemToToolbar;
-(void)insertItemToTable;

@end
