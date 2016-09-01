//
//  nationality.h
//  TVStreaming
//
//  Created by Gilang Esha Gautama on 11/29/12.
//  Copyright (c) 2012 ___GILANGGAUTAMA___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Country : NSObject

@property (strong, nonatomic) NSString *idCountry;
@property (strong, nonatomic) NSString *nation;
@property (strong, nonatomic) NSString *flag;

- (id)initWithName:(NSString*)name idCountry:(NSString*)idCountry flag:(NSString*)flag; 


@end
