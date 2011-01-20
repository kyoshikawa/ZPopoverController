//
//  PopoverSampleViewController.h
//  ZPopoverSample
//
//  Created by Kaz Yoshikawa on 11/01/20.
//  Copyright 2011 Electricwoods LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

//
//	PopoverSampleViewController
//
@interface PopoverSampleViewController : UIViewController
{
	UIBarButtonItem *test1BarButton;
	UIBarButtonItem *test2BarButton;
	UIBarButtonItem *test3BarButton;
	UIBarButtonItem *test4BarButton;
	UIBarButtonItem *test5BarButton;
	UIBarButtonItem *test6BarButton;
}
@property (retain) UIBarButtonItem *test1BarButton;
@property (retain) UIBarButtonItem *test2BarButton;
@property (retain) UIBarButtonItem *test3BarButton;
@property (retain) UIBarButtonItem *test4BarButton;
@property (retain) UIBarButtonItem *test5BarButton;
@property (retain) UIBarButtonItem *test6BarButton;

- (IBAction)test1Action:(id)sender;
- (IBAction)test2Action:(id)sender;
- (IBAction)test3Action:(id)sender;
- (IBAction)test4Action:(id)sender;
- (IBAction)test5Action:(id)sender;
- (IBAction)test6Action:(id)sender;

@end

