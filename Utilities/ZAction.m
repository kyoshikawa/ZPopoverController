//
//  ZAction.m
//
//  Created by Kaz Yoshikawa on 11/01/10.
//  Copyright 2011 Electricwoods LLC. All rights reserved.
//

#import "ZAction.h"


//
//	ZAction
//
@implementation ZAction

@synthesize title;
@synthesize target;
@synthesize action;
@synthesize object;

+ (ZAction *)actionWithTitle:(NSString *)aTitle target:(id)aTarget action:(SEL)aAction object:(id)aObject;
{
	ZAction *actionObject = [[[ZAction alloc] init] autorelease];
	actionObject.title = aTitle;
	actionObject.target = aTarget;
	actionObject.action = aAction;
	actionObject.object = aObject;
	return actionObject;
}

- (void) dealloc
{
	self.title = nil;
	self.target = nil;
	self.action = nil;
	self.object = nil;
	[super dealloc];
}

- (void)performAction
{
	[self.target performSelector:action withObject:object];
}

@end

