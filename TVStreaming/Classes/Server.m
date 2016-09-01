//
//  Server.m
//  TVStreaming
//
//  Created by Gilang Esha Gautama on 12/17/12.
//  Copyright (c) 2012 ___GILANGGAUTAMA___. All rights reserved.
//

#import "Server.h"

@implementation Server

- (id) initWithId:(NSString*)idServer url:(NSString*)url type:(NSString*)type quality:(NSString*)quality priority:(NSInteger)priority showAlert:(NSInteger)showAlert alertMessage:(NSString*)alertMessage {
    
    if ((self = [super init])) {
        self.idServer = idServer;
        self.url = url;
        self.type = type;
        self.quality = quality;
        self.priority = priority;
        self.showAlert = showAlert;
        self.alertMessage = alertMessage;
    }
    return self;

    
}

@end
