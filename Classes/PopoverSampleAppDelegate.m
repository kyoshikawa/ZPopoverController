//
//  PopoverSampleAppDelegate.m
//
//  Created by Kaz Yoshikawa on 11/01/20.
//  Copyright 2011 Electricwoods LLC. All rights reserved.
//

#import "PopoverSampleAppDelegate.h"
#import "PopoverSampleViewController.h"


//
//	PopoverSampleAppDelegate
//
@implementation PopoverSampleAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[self.window addSubview:self.navigationController.view];
	[self.window makeKeyAndVisible];
	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
	/*
	 Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	 Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	 */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	/*
	 Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	 */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	/*
	 Called when the application is about to terminate.
	 See also applicationDidEnterBackground:.
	 */
}

#pragma mark -

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
	/*
	 Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
	 */
}

- (void)dealloc
{
	[navigationController release];
	[window release];
	[super dealloc];
}


@end
