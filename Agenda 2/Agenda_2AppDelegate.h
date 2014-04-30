//
//  Agenda_2AppDelegate.h
//  Agenda 2
//
//  Created by Lee Hamilton on 10/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Schedual;

@interface Agenda_2AppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>{
    UIWindow *window;
    UITabBarController *tabBarController;
    //IBOutlet Schedual *schedual;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
//@property (nonatomic, retain) IBOutlet Schedual *schedual;

@end
