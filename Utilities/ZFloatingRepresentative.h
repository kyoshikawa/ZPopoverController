//
//  ZFloatingRepresentative.h
//
//  Created by Kaz Yoshikawa on 11/01/12.
//  Copyright 2011 Electricwoods LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZFloatingObject.h"


//
//	ZFloatingRepresentative
//
@interface ZFloatingRepresentative : NSObject
{
	NSString *identifer;
	id <ZFloatingObject> floating;
}
@property (retain) NSString *identifer;
@property (retain) id <ZFloatingObject> floating;
@property (readonly, getter=isActive) BOOL active;

+ (id)representativeWithIdentifer:(NSString *)aIdentifer;
- (id)initWithIdentifer:(NSString *)aIdentifer;
- (void)dismissAnimated:(BOOL)aAnimated;

@end
