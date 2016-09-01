//
//  Server.h
//  TVStreaming
//
//  Created by Gilang Esha Gautama on 12/17/12.
//  Copyright (c) 2012 ___GILANGGAUTAMA___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Server : NSObject

@property (strong, nonatomic) NSString *idServer;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *quality;
@property (readwrite) NSInteger priority;
@property (readwrite) NSInteger showAlert;
@property (strong, nonatomic) NSString *alertMessage;

- (id)initWithId:(NSString*)idServer url:(NSString*)url type:(NSString*)type quality:(NSString*)quality priority:(NSInteger)priority showAlert:(NSInteger)showAlert alertMessage:(NSString*)alertMessage;

@end
