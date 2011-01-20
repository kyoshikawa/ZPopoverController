//
//  ZAlertView.h
//
//  Created by Kaz Yoshikawa on 11/01/10.
//  Copyright 2011 Electricwoods LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZAction;


//
//	ZAlertView
//
@interface ZAlertView : UIAlertView <UIActionSheetDelegate>
{
	ZAction *cancelAction;
	NSArray *otherActions;
}
@property (retain) ZAction *cancelAction;
@property (retain) NSArray *otherActions;

- (id)initWithTitle:(NSString *)aTitle message:(NSString *)aMessage cancelAction:(ZAction *)aCancelAction otherActions:(NSArray *)aOtherActions;

@end
