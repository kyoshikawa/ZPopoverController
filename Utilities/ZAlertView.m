//
//  ZAlertView.m
//
//  Created by Kaz Yoshikawa on 11/01/10.
//  Copyright 2011 Electricwoods LLC. All rights reserved.
//

#import "ZAlertView.h"
#import "ZAction.h"


//
//	ZAlertView
//
@implementation ZAlertView

@synthesize cancelAction;
@synthesize otherActions;

- (id)initWithTitle:(NSString *)aTitle message:(NSString *)aMessage cancelAction:(ZAction *)aCancelAction otherActions:(NSArray *)aOtherActions
{
	if (self = [super initWithTitle:aTitle message:aMessage delegate:self cancelButtonTitle:aCancelAction.title
				otherButtonTitles:nil]) {
		for (ZAction *action in aOtherActions) {
			NSParameterAssert([action isKindOfClass:[ZAction class]]);
			NSParameterAssert(action.title);
			[self addButtonWithTitle:action.title];
		}
		self.cancelAction = aCancelAction;
		self.otherActions = aOtherActions;
	}
	return self;
}

#pragma mark -

- (void)dealloc
{
	self.cancelAction = nil;
	self.otherActions = nil;
	[super dealloc];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	ZAction *action = nil;
	if (cancelAction && cancelAction.title) {
		action = (buttonIndex == 0) ? cancelAction : [otherActions objectAtIndex:buttonIndex - 1];
	}
	else {
		action = [otherActions objectAtIndex:buttonIndex];
	}
	[action performAction];
}

- (id)delegate
{
	return self;
}

@end
