//
//  Station.m
//  TVStreaming
//
//  Created by Gilang Esha Gautama on 11/29/12.
//  Copyright (c) 2012 ___GILANGGAUTAMA___. All rights reserved.
//

#import "Station.h"

@implementation Station

- (id)initWithName:(NSString *)name idStation:(NSString *)idStation longName:(NSString *)longName description:(NSString *)description logo:(NSString*)logo {
    if ((self = [super init])) {
        self.idStation = idStation;
        self.name = name;
        self.longName = longName;
        self.description = description;
        self.logo = logo;
    }
    return self;
}

@end
