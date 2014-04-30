//
//  QuickLinksDetails.h
//  Agenda 2
//
//  Created by Lee Hamilton on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuickLinksDetails : UIViewController{
    IBOutlet UIWebView *webView;
    IBOutlet UIButton *back, *forward, *reload;    
}

@property(nonatomic,retain) IBOutlet UIWebView *webView;
@property(nonatomic,retain) IBOutlet UIButton *back;
@property(nonatomic,retain) IBOutlet UIButton *forward;
@property(nonatomic,retain) IBOutlet UIButton *reload;

-(IBAction)goBack:(id)sender;
-(IBAction)goForward:(id)sender;
-(IBAction)reloadPage:(id)sender;

@end
