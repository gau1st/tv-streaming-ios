//
//  nationality.h
//  TVStreaming
//
//  Created by Gilang Esha Gautama on 11/29/12.
//  Copyright (c) 2012 ___GILANGGAUTAMA___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Station : NSObject

@property (strong, nonatomic) NSString *idStation;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *longName;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *logo;

- (id)initWithName:(NSString*)name idStation:(NSString*)idStation longName:(NSString*)longName description:(NSString*)description logo:(NSString*)logo;

@end
