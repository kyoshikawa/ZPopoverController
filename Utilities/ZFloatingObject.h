//
//  ZFloatingObject.h
//
//  Created by Kaz Yoshikawa on 11/01/06.
//  Copyright 2011 Electricwoods LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ZFloatingObject;
@class ZFloatingRepresentative;


//	ZFloatingObject
//
//	UIPopoverController and UIActionSheet are both floating object that
//	should be visible one at a time.  They share the similar responsibilty
//	but they do they do not share the common class, but NSObject.  
//
//	In order to handle two class instances in the same way, ZFloatingObject
//	protocol is introduced.  In order to take advantage from this architecture,
//	use ZPopoverController, whcih is subclass of UIPopoverController that
//	conform to ZFloatingObject protocol.  Also use ZActionSheeet instead of
//	UIActionSheet to make your programming life a bit easier.


//
//	variables
//
extern NSString *kZFloatingObjectWillAppear;
extern NSString *kZFloatingObjectWillDisappear;


//
//	ZFloatingObject (protocol)
//
@protocol ZFloatingObject <NSObject>
@property (retain) id identifier;
@property (retain) id context;
@property (readonly, getter=isActive) BOOL active;

- (void)dismissAnimated:(BOOL)aAnimated;

@end


