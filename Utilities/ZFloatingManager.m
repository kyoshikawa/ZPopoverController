//
//  ZFloatingManager.m
//
//  Created by Kaz Yoshikawa on 11/01/06.
//  Copyright 2011 Electricwoods LLC. All rights reserved.
//

#import "ZFloatingManager.h"
#import "ZPopoverController.h"

static ZFloatingManager *gFloatingManager = nil;


//
//	ZFloatingManager
//
@implementation ZFloatingManager

#pragma mark -

+ (ZFloatingManager *)sharedManager
{
	if (!gFloatingManager) {
		gFloatingManager = [[ZFloatingManager alloc] init];
	}
	return gFloatingManager;
}

+ (void)dismissAnimated:(BOOL)aAnimated
{
	[[self sharedManager] dismissAnimated:aAnimated];
}

+ (BOOL)shouldFloatingWithIdentiferAppear:(NSString *)aIdentifer
{
	return [[self sharedManager] shouldFloatingWithIdentiferAppear:aIdentifer];
}

#pragma mark -

- (void) dealloc
{
	[floatings release], floatings = nil;
	[super dealloc];
}

#pragma mark -

- (NSMutableArray *)floatings
{
	if (!floatings) {
		floatings = [[NSMutableArray alloc] init];
	}
	return floatings;
}

- (void)addFloating:(id <ZFloatingObject>)aController
{
	[[self floatings] addObject:aController];
}

- (void)removeFloating:(id <ZFloatingObject>)aController
{
//	[[aController retain] autorelease]; // delayed release
	[[self floatings] removeObject:aController];
}

- (id <ZFloatingObject>)activeFloating
{
	NSMutableSet *activeControllers = [NSMutableSet set];

	for (id <ZFloatingObject> controller in [self floatings]) {
		if (controller.active) {
			[activeControllers addObject:controller];
		}
	}
	NSParameterAssert([activeControllers count] <= 1);
	return [activeControllers anyObject];
}

#pragma mark -

- (NSString *)activeIdentifer
{
	return self.activeFloating.identifer;
}

- (void)dismissAnimated:(BOOL)aAnimated
{
	[self.activeFloating dismissAnimated:aAnimated];
}

- (BOOL)shouldFloatingWithIdentiferAppear:(NSString *)aIdentifer
{
	id <ZFloatingObject> controller = self.activeFloating;
	if ([controller.identifer isEqualToString:aIdentifer]) {
		[controller dismissAnimated:YES];
		return NO;
	}
	return YES;
}

@end