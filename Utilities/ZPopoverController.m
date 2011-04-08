//
//  ZPopoverController.m
//
//  Created by Kaz Yoshikawa on 11/01/06.
//  Copyright 2011 Electricwoods LLC. All rights reserved.
//

#import "ZPopoverController.h"
#import "ZFloatingManager.h"


//
//	ZPopoverController
//
@implementation ZPopoverController

@synthesize identifier;
@synthesize context;

#pragma mark -

- (id)initWithContentViewController:(UIViewController *)aViewController
{
	if (self = [super initWithContentViewController:aViewController]) {
		[super setDelegate:self];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(floatingControllerWillAppear:)
					name:kZFloatingObjectWillAppear object:nil];
	}
	return self;
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:kZFloatingObjectWillAppear object:nil];
	if (self.popoverVisible) {
		[self dismissPopoverAnimated:NO];
	}

	self.identifier = nil;
	self.context = nil;
	originalDelegate = nil;
	[super dealloc];
}

- (BOOL)isActive
{
	return self.popoverVisible;
}

#pragma mark -

- (void)floatingObjectWillAppear
{
	[[ZFloatingManager sharedManager] addFloating:self];
	[[NSNotificationCenter defaultCenter] postNotificationName:kZFloatingObjectWillAppear object:self userInfo:nil];
}

- (void)floatingObjectWillDisappear
{
	[[NSNotificationCenter defaultCenter] postNotificationName:kZFloatingObjectWillDisappear object:self userInfo:nil];
	[[ZFloatingManager sharedManager] removeFloating:self];
}

- (BOOL)shouldAppear
{
	id <ZFloatingObject> controller = [ZFloatingManager sharedManager].activeFloating;
	if ([controller.identifier isEqualToString:self.identifier]) {
		return NO;
	}
	return YES;
}

#pragma mark -

- (void)presentFromBarButtonItem:(UIBarButtonItem *)aButtonItem animated:(BOOL)aAnimated
{
	[self presentPopoverFromBarButtonItem:aButtonItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:aAnimated];
}

#pragma mark -

- (void)presentPopoverFromBarButtonItem:(UIBarButtonItem *)aItem permittedArrowDirections:(UIPopoverArrowDirection)aArrowDirections animated:(BOOL)aAnimated
{
	if ([self shouldAppear]) {
		[self floatingObjectWillAppear];
		[super presentPopoverFromBarButtonItem:aItem permittedArrowDirections:aArrowDirections animated:aAnimated];
	}
}

- (void)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections animated:(BOOL)animated
{
	if ([self shouldAppear]) {
		[self floatingObjectWillAppear];
		[super presentPopoverFromRect:rect inView:view permittedArrowDirections:arrowDirections animated:animated];
	}
}

- (void)dismissAnimated:(BOOL)aAnimated
{
	[self dismissPopoverAnimated:NO];
}

- (void)dismissPopoverAnimated:(BOOL)aAnimated
{
	if ([originalDelegate respondsToSelector:@selector(popoverControllerWillDismissPopover_:)]) {
		[(id <ZPopoverControllerDelegate>)originalDelegate popoverControllerWillDismissPopover_:self];
	}

	[self floatingObjectWillDisappear];

	[super dismissPopoverAnimated:aAnimated];
}

#pragma mark -

- (id <UIPopoverControllerDelegate>)delegate
{
	return self;
}

- (void)setDelegate:(id <UIPopoverControllerDelegate>)aDelegate
{
	if (originalDelegate != aDelegate) {
		originalDelegate = aDelegate;
	}
}

#pragma mark -

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
	if ([originalDelegate respondsToSelector:@selector(popoverControllerDidDismissPopover:)]) {
		[originalDelegate popoverControllerDidDismissPopover:popoverController];
	}
}

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
	BOOL result = YES;
	if ([originalDelegate respondsToSelector:@selector(popoverControllerShouldDismissPopover:)]) {
		result = [originalDelegate popoverControllerShouldDismissPopover:popoverController];
	}

	if (result && self.active) {
		// wondering if is there a case, should method returns NO, but system 
		[self floatingObjectWillDisappear];
	}
	return result;
}

#pragma mark -

- (void)floatingControllerWillAppear:(NSNotification *)aNotification
{
	if ([aNotification object] && [aNotification object] != self && self.active) {
		[self dismissAnimated:NO];
	}
}

@end


