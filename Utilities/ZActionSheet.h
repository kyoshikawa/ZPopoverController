//
//  ZActionSheet.h
//
//  Created by Kaz Yoshikawa on 11/01/06.
//  Copyright 2011 Electricwoods LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFloatingObject.h"
@class ZAction;


//
//	ZActionSheet
//
@interface ZActionSheet : UIActionSheet <ZFloatingObject, UIActionSheetDelegate>
{
	id identifier;
	id context;
	id <UIActionSheetDelegate> originalDelegate;
	ZAction *cancelAction;
	ZAction *destructiveAction;
	NSArray *otherActions;
}
@property (retain) ZAction *cancelAction;
@property (retain) ZAction *destructiveAction;
@property (retain) NSArray *otherActions;

- (id)initWithTitle:(NSString *)title cancelAction:(ZAction *)aCancelAction destructiveAction:(ZAction *)aDestructiveAction otherActions:(NSArray *)aOtherActions;

@end
