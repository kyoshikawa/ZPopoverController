//
//  SamplePopover.m
//  ZPopoverSample
//
//  Created by Kaz Yoshikawa on 11/01/20.
//  Copyright 2011 Electricwoods LLC. All rights reserved.
//

#import "SamplePopoverContentViewController.h"


//
//	SamplePopover
//
@implementation SamplePopoverContentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.contentSizeForViewInPopover = self.view.bounds.size;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)aInterfaceOrientation
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
	[super viewDidUnload];
}

- (void)dealloc
{
	[super dealloc];
}


@end
