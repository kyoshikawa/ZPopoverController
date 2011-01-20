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
	NSMutableArray *floatings;
}
+ (ZFloatingManager *)sharedManager;
+ (void)dismissAnimated:(BOOL)aAnimated;
+ (BOOL)shouldFloatingWithIdentiferAppear:(NSString *)aIdentifer;

@property (readonly) NSMutableArray *floatings;
@property (readonly) id <ZFloatingObject> activeFloating;
@property (readonly) NSString *activeIdentifer;

- (void)addFloating:(id <ZFloatingObject>)aController;
- (void)removeFloating:(id <ZFloatingObject>)aController;
- (void)dismissAnimated:(BOOL)aAnimated;
- (BOOL)shouldFloatingWithIdentiferAppear:(NSString *)aIdentifer;

@end

