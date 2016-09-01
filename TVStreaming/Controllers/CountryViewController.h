//
//  NationalityViewController.h
//  TVStreaming
//
//  Created by Gilang Esha Gautama on 11/21/12.
//  Copyright (c) 2012 ___GILANGGAUTAMA___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface CountryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    MBProgressHUD *hud;
    
}

@property(strong, nonatomic) NSMutableArray *nationList;

@end
