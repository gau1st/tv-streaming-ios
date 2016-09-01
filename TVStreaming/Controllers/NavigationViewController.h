//
//  NavigationViewController.h
//  TVStreaming
//
//  Created by Gilang Esha Gautama on 11/21/12.
//  Copyright (c) 2012 ___GILANGGAUTAMA___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface NavigationViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    MBProgressHUD *hud;
    
}


@property (assign, nonatomic) BOOL fromCountry;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *idCountry;
@property (strong, nonatomic) NSMutableArray *channelList;
@property (strong, nonatomic) NSMutableArray *serverList;

@end
