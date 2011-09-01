//
//  ZFloatingManager.h
//
//  Created by Kaz Yoshikawa on 11/01/06.
//  Copyright 2011 Electricwoods LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZFloatingObject.h"
@class ZFloatingRepresentative;
@class ZPopoverController;

//
//	ZFloatingControllerManager
//
@interface ZFloatingManager : NSObject
{
	NSMutableSet *floatings;
}
+ (ZFloatingManager *)sharedManager;
+ (void)dismissAnimated:(BOOL)aAnimated;
+ (BOOL)shouldFloatingWithIdentifierAppear:(NSString *)aIdentifier;

@property (readonly) NSMutableSet *floatings;
@property (readonly) id <ZFloatingObject> activeFloating;
@property (readonly) NSString *activeIdentifier;

- (void)addFloating:(id <ZFloatingObject>)aController;
- (void)removeFloating:(id <ZFloatingObject>)aController;
- (void)dismissAnimated:(BOOL)aAnimated;
- (BOOL)shouldFloatingWithIdentifierAppear:(NSString *)aIdentifier;

@end

