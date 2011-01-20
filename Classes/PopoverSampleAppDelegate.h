//
//  PopoverSampleAppDelegate.h
//
//  Created by Kaz Yoshikawa on 11/01/20.
//  Copyright 2011 Electricwoods LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PopoverSampleViewController;

//
//	PopoverSampleAppDelegate
//
@interface PopoverSampleAppDelegate : NSObject <UIApplicationDelegate>
{
    UIWindow *window;
	UINavigationController *navigationController;
}
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

