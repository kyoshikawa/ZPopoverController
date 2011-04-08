//
//  ZPopoverController.h
//
//  Created by Kaz Yoshikawa on 11/01/06.
//  Copyright 2011 Electricwoods LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFloatingObject.h"
@class ZPopoverController;


//
//	ZPopoverControllerDelegate
//
@protocol ZPopoverControllerDelegate <UIPopoverControllerDelegate>

- (void)popoverControllerWillDismissPopover_:(ZPopoverController *)aPopoverController;

@end


//
//	ZPopoverController
//
@interface ZPopoverController : UIPopoverController <ZFloatingObject, UIPopoverControllerDelegate>
{
	id identifier;
	id context;
	id <UIPopoverControllerDelegate> originalDelegate;
}

- (void)presentFromBarButtonItem:(UIBarButtonItem *)aButtonItem animated:(BOOL)aAnimated;

@end
