//
//  UIFont_Name_GrabberAppDelegate.m
//  UIFont Name Grabber
//
//  Created by Nick Forge on 4/08/10.
//  Copyright Nick Forge 2010. All rights reserved.
//

#import "UIFont_Name_GrabberAppDelegate.h"
#import "UIFont_Name_GrabberViewController.h"

@implementation UIFont_Name_GrabberAppDelegate

@synthesize window;
@synthesize viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.

    // Add the view controller's view to the window and display.
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];

	[viewController sendMail];
	
    return YES;
}

- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
