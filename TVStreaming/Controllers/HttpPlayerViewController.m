//
//  HttpPlayerViewController.m
//  AlayStreamer
//
//  Created by Himawan Putra on 11/23/12.
//  Copyright (c) 2012 Anonim Dev Studio. All rights reserved.
//

#import "HttpPlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface HttpPlayerViewController ()

@end

@implementation HttpPlayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if((interfaceOrientation == UIInterfaceOrientationLandscapeLeft) ||
       (interfaceOrientation == UIInterfaceOrientationLandscapeRight))  {
        return YES;
    }
    return NO;
}



@end
