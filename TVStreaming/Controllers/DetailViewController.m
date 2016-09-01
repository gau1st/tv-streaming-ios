//
//  DetailViewController.m
//  TVStreaming
//
//  Created by Gilang Esha Gautama on 11/21/12.
//  Copyright (c) 2012 ___GILANGGAUTAMA___. All rights reserved.
//

#import "DetailViewController.h"

#import <AudioToolbox/AudioToolbox.h>

#import "FFEngine/FFEngine.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

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
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(appBecomeActive)
                                                 name: UIApplicationDidBecomeActiveNotification object:nil];
    
    
	[[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(appResignActive)
                                                 name: UIApplicationWillResignActiveNotification object:nil];
    
    
    self.titleForP.title = self.titleName;
    
    [self initSDK];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    if (UIInterfaceOrientationIsLandscape(orientation))
        return YES;
    
    return NO;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initSDK
{
    id<IELMediaPlayer> player = loadELMediaPlayer();
    
    [player setDelegate: self];
    [player setAutoPlayAfterOpen: YES];
    [player setVideoContainerView: self.playerAreaView];
    [player setPlayerScreenType:ELScreenType_ASPECT_FULL_SCR];
}

-(void) startPlaying
{
    id<IELMediaPlayer> player = loadELMediaPlayer();
    
    if( [player openMedia: self.urlRTMP] )
    {
        self.pEstablishedTimeLabel.text = @"Opening";
        self.statusLabel.text = @"Opening";
    }
}

-(void) removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

-(NSString *)timeFormatted:(int)totalSeconds
{
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
}

//!----------------------------------------------------------------------------------

- (void)openFailed
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: nil
                                                         message: @"Open Error!"
                                                        delegate: nil
                                               cancelButtonTitle: @"Close"
                                               otherButtonTitles: nil];
    [alertView show];
}

- (void)readyToPlay
{
    NSLog(@"%s %d", __FUNCTION__, __LINE__);
    
    self.statusLabel.text = @"Ready";
}

// player -> UI
- (void)mediaWidth: (size_t) width height: (size_t) height
{
    NSLog(@"%s %d, width: %ld, height: %ld", __FUNCTION__, __LINE__, width, height);
}

// 本地缓冲很快,本地不送,网络送
- (void)bufferPercent:(int)percentage
{
    self.statusLabel.text = [NSString stringWithFormat: @"%d%%", percentage];
    
    self.pEstablishedTimeLabel.text = [NSString stringWithFormat: @"%d%%", percentage];
}

// 总长度
- (void)mediaDuration:(size_t)duration
{
    NSLog(@"%s %d", __FUNCTION__, __LINE__);
    _videoDuration = duration;
}

// player -> UI
// 当前进度
- (void)mediaPosition:(size_t)position
{
    
    self.statusLabel.text = [self timeFormatted:position / 1000];
    
    _videoPostion = position;
    
    self.pEstablishedTimeLabel.text = [self timeFormatted:position / 1000];
    self.pLeftTimeLabel.text = [NSString stringWithFormat: @"-%@", [self timeFormatted:(_videoDuration - _videoPostion) / 1000]];
    
    self.progressPSlider.value = 1.0 * _videoPostion / _videoDuration;
}

//!----------------------------------------------------------------------------------

- (void)appBecomeActive
{
    [self closeVideo: nil];
}

-(void)appResignActive
{
    [self stopPlayVideo:nil];
}


- (void)viewDidUnload {
    [self setNavibar:nil];
    [self setControlView:nil];
    [super viewDidUnload];
}

#define kDuration 0.6

#pragma mark - 播放控制，各种播放method
//!----------------------------------------------------------------------------------
- (IBAction)onButtonBackPressed:(id)sender
{
    [self stopPlayVideo: nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction)closeVideo:(id)sender {
    
    [self stopPlayVideo:nil];
    
    [self removeNotification];
    
    [self dismissViewControllerAnimated:YES completion:Nil];
    
}
#
//! 播放视频

- (IBAction)showUpShowOffNavigation:(id)sender {
    
    if (self.controlView.isHidden) {
        self.controlView.hidden = NO;
        self.navibar.hidden = NO;
    } else {
        self.controlView.hidden = YES;
        self.navibar.hidden = YES;
    }
    
}

- (IBAction)sliderValueChanged:(id)sender {
    UISlider *slider = (UISlider *) sender;
    
    size_t currentPosition = (slider.value * _videoDuration);
    
    id<IELMediaPlayer> player = loadELMediaPlayer();
    
    [player seekTo: currentPosition];
}

-(IBAction) startPlayVideo:(id)sender
{
    
    [self startPlaying];
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
}

//! 暂停播放
-(IBAction) pausePlayVideo:(id)sender
{
    static int i = 0;
    id<IELMediaPlayer> player = loadELMediaPlayer();
    
    if(i)
    {
        // resume
        i = 0;
        [player resumePlay];
    }
    else
    {
        // Pause
        i = 1;
        [player pausePlay];
        
        self.pEstablishedTimeLabel.text = @"Paused";
    }
}

//! 停止播放
-(IBAction) stopPlayVideo:(id)sender
{
    id<IELMediaPlayer> player = loadELMediaPlayer();
    
    [player stopPlay];
    
    [UIApplication sharedApplication].idleTimerDisabled = NO;
}

//! 到退播放
-(IBAction) rewindPlayVideo:(id)sender
{
    id<IELMediaPlayer> player = loadELMediaPlayer();
    
    [player seekTo: _videoPostion - 10 * 1000];
}

//! 快进播放
-(IBAction) forwardPlayVideo:(id)sender
{
    id<IELMediaPlayer> player = loadELMediaPlayer();
    
    [player seekTo: _videoPostion + 10 * 1000];
}

//! 快照
-(IBAction) takePicture:(id)sender
{
    self.pEstablishedTimeLabel.text = @"Nop";
}


//!----------------------------------------------------------------------------------




@end
