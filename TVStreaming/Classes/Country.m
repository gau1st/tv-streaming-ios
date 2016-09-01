//
//  nationality.m
//  TVStreaming
//
//  Created by Gilang Esha Gautama on 11/29/12.
//  Copyright (c) 2012 ___GILANGGAUTAMA___. All rights reserved.
//

#import "Country.h"

@implementation Country

- (id)initWithName:(NSString*)name idCountry:(NSString*)idCountry flag:(NSString*)flag;
{
    if ((self = [super init])) {
        self.idCountry = idCountry;
        self.nation = name;
        self.flag = flag;
    }
    return self;
    
}

@end
