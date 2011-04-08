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
	NSString *identifier;
	id <ZFloatingObject> floating;
}
@property (retain) NSString *identifier;
@property (retain) id <ZFloatingObject> floating;
@property (readonly, getter=isActive) BOOL active;

+ (id)representativeWithIdentifier:(NSString *)aIdentifier;
- (id)initWithIdentifier:(NSString *)aIdentifier;
- (void)dismissAnimated:(BOOL)aAnimated;

@end
