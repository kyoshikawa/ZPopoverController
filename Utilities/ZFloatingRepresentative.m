//
//  ZFloatingControllerManager.m
//
//  Created by Kaz Yoshikawa on 11/01/12.
//  Copyright 2011 Electricwoods LLC. All rights reserved.
//

#import "ZFloatingRepresentative.h"
#import "ZFloatingManager.h"
#import "ZPopoverController.h"
#import "ZActionSheet.h"



//
//	ZFloatingRepresentative
//
@implementation ZFloatingRepresentative

@synthesize identifier;
@synthesize floating;

+ (id)representativeWithIdentifier:(NSString *)aIdentifier
{
	if ([[ZFloatingManager sharedManager] shouldFloatingWithIdentifierAppear:aIdentifier]) {
		return [[[ZFloatingRepresentative alloc] initWithIdentifier:aIdentifier] autorelease];
	}
	return nil;
}


#pragma mark -

- (id)initWithIdentifier:(NSString *)aIdentifier
{
	NSParameterAssert(aIdentifier);

	if (self = [super init]) {
		self.identifier = aIdentifier;
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(floatingControllerWillAppear:)
					name:kZFloatingObjectWillAppear object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(floatingControllerWillDisappear:)
					name:kZFloatingObjectWillDisappear object:nil];
	}
	return self;
}

- (void)dealloc
{
	if (floating) {
		[floating dismissAnimated:NO];
		floating = nil;
	}

	[[NSNotificationCenter defaultCenter] removeObserver:self];
	self.identifier = nil;
	[super dealloc];
}

- (BOOL)isActive
{
	return floating.active;
}

#pragma mark -

- (BOOL)shouldAppear
{
	return [[ZFloatingManager sharedManager] shouldFloatingWithIdentifierAppear:self.identifier];
}

- (void)dismissAnimated:(BOOL)aAnimated
{
	if (floating && floating.active) {
		[floating dismissAnimated:aAnimated];
	}
	[floating autorelease];
	floating = nil;
}

#pragma mark -

- (id <ZFloatingObject>)floating
{
	return floating;
}

- (void)setFloating:(id <ZFloatingObject>)aFloatingController
{
	if (floating != aFloatingController) {

		NSParameterAssert(aFloatingController == nil ||
				([aFloatingController isKindOfClass:[ZPopoverController class]] ||	
				 [aFloatingController isKindOfClass:[ZActionSheet class]]));

		// dismiss current floating controller
		[self dismissAnimated:NO];

		NSParameterAssert(floating == nil);
		floating = [aFloatingController retain];
		floating.identifier = self.identifier;
	}
}

#pragma mark -

- (void)floatingControllerWillAppear:(NSNotification *)aNotification
{
	id <ZFloatingObject> controller = [aNotification object];
	if (controller != floating) {
		[self dismissAnimated:NO];
		NSParameterAssert(floating == nil);
	}
}

- (void)floatingControllerWillDisappear:(NSNotification *)aNotification
{
	id <ZFloatingObject> controller = [aNotification object];
	if (controller == floating) {
		[floating autorelease];
		floating = nil;
	}
}

@end
