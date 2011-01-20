//
//  PopoverSampleViewController.m
//  ZPopoverSample
//
//  Created by Kaz Yoshikawa on 11/01/20.
//  Copyright 2011 Electricwoods LLC. All rights reserved.
//

#import "PopoverSampleViewController.h"
#import "SamplePopoverContentViewController.h"
#import "ZPopoverController.h"
#import "ZFloatingManager.h"
#import "ZActionSheet.h"
#import "ZAlertView.h"
#import "ZAction.h"


//
//	PopoverSampleViewController
//
@implementation PopoverSampleViewController

@synthesize test1BarButton;
@synthesize test2BarButton;
@synthesize test3BarButton;
@synthesize test4BarButton;
@synthesize test5BarButton;
@synthesize test6BarButton;


- (id)initWithNibName:(NSString *)aNibName bundle:(NSBundle *)aBundle
{
	if (self = [super initWithNibName:aNibName bundle:aBundle]) {
	}
	return self;
}

- (void)viewWillAppear:(BOOL)aAnimated
{
	[super viewWillAppear:aAnimated];
	
	self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad
{
	self.contentSizeForViewInPopover = self.view.bounds.size;
    [super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
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
	self.test1BarButton = nil;
	self.test2BarButton = nil;
	self.test3BarButton = nil;
	self.test4BarButton = nil;
	self.test5BarButton = nil;
	self.test6BarButton = nil;

    [super dealloc];
}

#pragma mark -

- (IBAction)test1Action:(id)sender
{
	if ([ZFloatingManager shouldFloatingWithIdentiferAppear:@"test1"]) {
		SamplePopoverContentViewController *contentViewController =
				[[[SamplePopoverContentViewController alloc] initWithNibName:@"SamplePopover1" bundle:nil] autorelease];
		ZPopoverController *popoverController = 
				[[[ZPopoverController alloc] initWithContentViewController:contentViewController] autorelease];
		popoverController.identifer = @"test1";
		[popoverController presentFromBarButtonItem:sender animated:YES];
	}
}

- (IBAction)test2Action:(id)sender
{
	if ([ZFloatingManager shouldFloatingWithIdentiferAppear:@"test2"]) {
		SamplePopoverContentViewController *contentViewController =
				[[[SamplePopoverContentViewController alloc] initWithNibName:@"SamplePopover2" bundle:nil] autorelease];
		ZPopoverController *popoverController = 
				[[[ZPopoverController alloc] initWithContentViewController:contentViewController] autorelease];
		popoverController.identifer = @"test2";
		[popoverController presentFromBarButtonItem:sender animated:YES];
	}
}

- (IBAction)test3Action:(id)sender
{
	if ([ZFloatingManager shouldFloatingWithIdentiferAppear:@"test3"]) {
		SamplePopoverContentViewController *contentViewController =
				[[[SamplePopoverContentViewController alloc] initWithNibName:@"SamplePopover3" bundle:nil] autorelease];
		ZPopoverController *popoverController = 
				[[[ZPopoverController alloc] initWithContentViewController:contentViewController] autorelease];
		popoverController.identifer = @"test3";
		[popoverController presentFromBarButtonItem:sender animated:YES];
	}
}

- (IBAction)test4Action:(id)sender
{
	if ([ZFloatingManager shouldFloatingWithIdentiferAppear:@"test4"]) {

		ZAction *cancel = [ZAction actionWithTitle:@"Cancel" target:self action:nil object:nil];
		ZAction *destroy = [ZAction actionWithTitle:@"Clear" target:self action:@selector(colorAction:) object:[UIColor clearColor]];
		ZAction *option1 = [ZAction actionWithTitle:@"Blue" target:self action:@selector(colorAction:) object:[UIColor blueColor]];
		ZAction *option2 = [ZAction actionWithTitle:@"Red" target:self action:@selector(colorAction:) object:[UIColor redColor]];
		ZAction *option3 = [ZAction actionWithTitle:@"Green" target:self action:@selector(colorAction:) object:[UIColor greenColor]];
		ZAction *option4 = [ZAction actionWithTitle:@"Orange" target:self action:@selector(colorAction:) object:[UIColor orangeColor]];

		ZActionSheet *sheet = [[[ZActionSheet alloc] initWithTitle:@"Title" cancelAction:cancel destructiveAction:destroy
					otherActions:[NSArray arrayWithObjects:option1, option2, option3, option4, nil]] autorelease];
		sheet.identifer = @"test4";
		[sheet showFromBarButtonItem:sender animated:YES];
	}
}

- (IBAction)test5Action:(id)sender
{
	if ([ZFloatingManager shouldFloatingWithIdentiferAppear:@"test5"]) {

		ZAction *destroy = [ZAction actionWithTitle:@"Clear" target:self action:@selector(colorAction:) object:[UIColor clearColor]];
		ZAction *option1 = [ZAction actionWithTitle:@"Blue" target:self action:@selector(colorAction:) object:[UIColor blueColor]];
		ZAction *option2 = [ZAction actionWithTitle:@"Red" target:self action:@selector(colorAction:) object:[UIColor redColor]];
		ZAction *option3 = [ZAction actionWithTitle:@"Green" target:self action:@selector(colorAction:) object:[UIColor greenColor]];
		ZAction *option4 = [ZAction actionWithTitle:@"Orange" target:self action:@selector(colorAction:) object:[UIColor orangeColor]];

		ZActionSheet *sheet = [[[ZActionSheet alloc] initWithTitle:@"Title" cancelAction:nil destructiveAction:destroy
					otherActions:[NSArray arrayWithObjects:option1, option2, option3, option4, nil]] autorelease];
		sheet.identifer = @"test5";
		[sheet showFromBarButtonItem:sender animated:YES];
	}
}

- (IBAction)test6Action:(id)sender
{
	[ZFloatingManager dismissAnimated:YES];
	ZAction *cancelAction = [ZAction actionWithTitle:@"Cancel" target:nil action:nil object:nil];
	ZAction *option1 = [ZAction actionWithTitle:@"Brown" target:self action:@selector(colorAction:) object:[UIColor brownColor]];
	ZAction *option2 = [ZAction actionWithTitle:@"Gray" target:self action:@selector(colorAction:) object:[UIColor grayColor]];
	ZAlertView *alertView = [[[ZAlertView alloc] initWithTitle:@"ZAlert Title"	message:@"Some message"
			cancelAction:cancelAction
			otherActions:[NSArray arrayWithObjects:option1, option2, nil]] autorelease];
	[alertView show];
}

#pragma mark -

- (void)colorAction:(id)object
{
	NSParameterAssert([object isKindOfClass:[UIColor class]]);
	self.view.backgroundColor = object;
}

@end
