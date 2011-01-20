//
//  ZActionSheet.m
//
//  Created by Kaz Yoshikawa on 11/01/06.
//  Copyright 2011 Electricwoods LLC. All rights reserved.
//

#import <stdarg.h>
#import "ZActionSheet.h"
#import "ZFloatingManager.h"
#import "ZAction.h"

//
//	ZActionSheet
//
@implementation ZActionSheet

@synthesize identifer;
@synthesize context;
@synthesize cancelAction;
@synthesize destructiveAction;
@synthesize otherActions;

#pragma mark -

- (id)initWithTitle:(NSString *)title delegate:(id < UIActionSheetDelegate >)delegate
			cancelButtonTitle:(NSString *)cancelButtonTitle
			destructiveButtonTitle:(NSString *)destructiveButtonTitle
			otherButtonTitles:(NSString *)otherButtonTitles, ...
{
	va_list args;
	va_start(args, otherButtonTitles);

	if (self = [super initWithTitle:title delegate:self cancelButtonTitle:cancelButtonTitle
				destructiveButtonTitle:destructiveButtonTitle
				otherButtonTitles:nil]) {

		originalDelegate = delegate;

		for (NSString *arg = otherButtonTitles; arg != nil; arg = va_arg(args, NSString*)) {
			[super addButtonWithTitle:arg];
		}

		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(floatingControllerWillAppear:)
					name:kZFloatingObjectWillAppear object:nil];
		[[ZFloatingManager sharedManager] addFloating:self];
	}

	va_end(args);
	return self;
}

- (id)initWithTitle:(NSString *)aTitle cancelAction:(ZAction *)aCancelAction destructiveAction:(ZAction *)aDestructiveAction otherActions:(NSArray *)aOtherActions
{
	if (self = [super initWithTitle:aTitle delegate:nil cancelButtonTitle:aCancelAction.title
				destructiveButtonTitle:aDestructiveAction.title otherButtonTitles:nil]) {

		[super setDelegate:self];
		self.cancelAction = aCancelAction;
		self.destructiveAction = aDestructiveAction;
		for (ZAction *action in aOtherActions) {
			NSParameterAssert([action isKindOfClass:[ZAction class]]);
			NSParameterAssert(action.title);
			[self addButtonWithTitle:action.title];
		}
		self.otherActions = aOtherActions;

		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(floatingControllerWillAppear:)
					name:kZFloatingObjectWillAppear object:nil];
	}
	return self;
}

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:kZFloatingObjectWillAppear object:nil];

	if (self.visible) {
		[self dismissAnimated:NO];
	}

	self.identifer = nil;
	self.context = nil;
	originalDelegate = nil;
	[super dealloc];
}

- (BOOL)isActive
{
	return self.visible;
}

#pragma mark -

- (void)floatingObjectWillAppear
{
	[[ZFloatingManager sharedManager] addFloating:self];
	[[NSNotificationCenter defaultCenter] postNotificationName:kZFloatingObjectWillAppear object:self userInfo:nil];
}

- (void)floatingObjectWillDisappear
{
	[[ZFloatingManager sharedManager] removeFloating:self];
	[[NSNotificationCenter defaultCenter] postNotificationName:kZFloatingObjectWillDisappear object:self userInfo:nil];
}

- (BOOL)shouldAppear
{
	id <ZFloatingObject> controller = [ZFloatingManager sharedManager].activeFloating;
//	if (controller == nil || controller != self) {
	if (![controller.identifer isEqualToString:self.identifer]) {
		return YES;
	}
	return NO;
}

#pragma mark -

- (void)presentFromBarButtonItem:(UIBarButtonItem *)aButtonItem animated:(BOOL)aAnimated
{
	[self showFromBarButtonItem:aButtonItem animated:aAnimated];
}

- (void)dismissAnimated:(BOOL)aAnimated
{
	if (self.visible) {
		[self floatingObjectWillDisappear];
	}
	[self dismissWithClickedButtonIndex:[self cancelButtonIndex] animated:aAnimated];
}

#pragma mark -

- (void)showFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated
{
	if ([self shouldAppear]) {
		[self floatingObjectWillAppear];
		[super showFromBarButtonItem:item animated:animated];
	}
}

- (void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated
{
	if ([self shouldAppear]) {
		[self floatingObjectWillAppear];
		[super showFromRect:rect inView:view animated:animated];
	}
}

- (void)showFromTabBar:(UITabBar *)view
{
	if ([self shouldAppear]) {
		[self floatingObjectWillAppear];
		[super showFromTabBar:view];
	}
}

- (void)showFromToolbar:(UIToolbar *)view
{
	if ([self shouldAppear]) {
		[self floatingObjectWillAppear];
		[super showFromToolbar:view];
	}
}

- (void)showInView:(UIView *)view
{
	if ([self shouldAppear]) {
		[self floatingObjectWillAppear];
		[super showInView:view];
	}
}

#pragma mark -

- (id <UIActionSheetDelegate>)delegate
{
	return self;
}

- (void)setDelegate:(id <UIActionSheetDelegate>)aDelegate
{
	if (originalDelegate != aDelegate) {
		originalDelegate = aDelegate;
	}
}

#pragma mark -

- (void)actionSheet:(UIActionSheet *)aActionSheet clickedButtonAtIndex:(NSInteger)aButtonIndex
{
	if ([originalDelegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
		[originalDelegate actionSheet:aActionSheet clickedButtonAtIndex:aButtonIndex];
	}
	
	if ([self cancelButtonIndex] == aButtonIndex) {
		[cancelAction performAction];
	}
	else if ([self destructiveButtonIndex] == aButtonIndex) {
		[destructiveAction performAction];
	}
	else {
		NSInteger cancelButtonOffset = ([self cancelButtonIndex] >= 0) ? 1 : 0;
		NSInteger destructiveButtonOffset = ([self destructiveButtonIndex] >= 0) ? 1 : 0;
		NSInteger otherButtonIndex = aButtonIndex - cancelButtonOffset - destructiveButtonOffset;
		if (otherButtonIndex < [otherActions count]) {
			ZAction *action = [otherActions objectAtIndex:otherButtonIndex];
			[action performAction];
		}
	}
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if ([originalDelegate respondsToSelector:@selector(actionSheet:didDismissWithButtonIndex:)]) {
		[originalDelegate actionSheet:actionSheet didDismissWithButtonIndex:buttonIndex];
	}
}

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if ([originalDelegate respondsToSelector:@selector(actionSheet:willDismissWithButtonIndex:)]) {
		[originalDelegate actionSheet:actionSheet willDismissWithButtonIndex:buttonIndex];
	}
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
	if ([originalDelegate respondsToSelector:@selector(actionSheetCancel:)]) {
		[originalDelegate actionSheetCancel:actionSheet];
	}
}

- (void)didPresentActionSheet:(UIActionSheet *)actionSheet
{
	if ([originalDelegate respondsToSelector:@selector(didPresentActionSheet:)]) {
		[originalDelegate didPresentActionSheet:actionSheet];
	}
}

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
{
	if ([originalDelegate respondsToSelector:@selector(willPresentActionSheet:)]) {
		[originalDelegate willPresentActionSheet:actionSheet];
	}
}

#pragma mark -

- (void)floatingControllerWillAppear:(NSNotification *)aNotification
{
	if ([aNotification object] && [aNotification object] != self && self.active) {
		[self dismissAnimated:NO];
	}
}

@end
