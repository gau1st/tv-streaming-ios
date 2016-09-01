//
//  DetailViewController.h
//  TVStreaming
//
//  Created by Gilang Esha Gautama on 11/21/12.
//  Copyright (c) 2012 ___GILANGGAUTAMA___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <ELPlayerMessageProtocol>
{
    size_t _videoDuration;
    int _videoPostion;
}

@property (strong, nonatomic) NSString *urlRTMP;

@property (nonatomic, retain) IBOutlet UIView *playerAreaView;

@property (nonatomic, retain) IBOutlet UILabel *statusLabel;

@property (nonatomic, retain) NSString *titleName;
@property (nonatomic, retain) IBOutlet UINavigationItem *titleForP;

@property (strong, nonatomic) IBOutlet UINavigationBar *navibar;

@property (strong, nonatomic) IBOutlet UIView *controlView;

@property (nonatomic, retain) IBOutlet UIView *protraitNavView;

@property (nonatomic, retain) IBOutlet UIView *protraitBottomView;

@property (nonatomic, retain) IBOutlet UISlider *progressPSlider;

@property (nonatomic, retain) IBOutlet UILabel *pEstablishedTimeLabel;

@property (nonatomic, retain) IBOutlet UILabel *pLeftTimeLabel;

@end
