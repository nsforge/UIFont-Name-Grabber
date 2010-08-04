//
//  UIFont_Name_GrabberAppDelegate.h
//  UIFont Name Grabber
//
//  Created by Nick Forge on 4/08/10.
//  Copyright Nick Forge 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIFont_Name_GrabberViewController;

@interface UIFont_Name_GrabberAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UIFont_Name_GrabberViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UIFont_Name_GrabberViewController *viewController;

@end

