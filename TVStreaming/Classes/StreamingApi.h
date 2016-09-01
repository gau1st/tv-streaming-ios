//
//  StreamingApi.h
//  TVStreaming
//
//  Created by Gilang Esha Gautama on 12/18/12.
//  Copyright (c) 2012 ___GILANGGAUTAMA___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StreamingApi : NSObject 


- (void) getAllStationsWithCallback:(void(^)(NSDictionary*))cb;
- (void) getAllCountriesWithCallback:(void(^)(NSDictionary*))cb;
- (void) getStationsByCountry:(NSString*) countryId withCallback:(void(^)(NSDictionary*))cb;
- (void) getServersByStation:(NSString*) stationId withCallback:(void(^)(NSDictionary*))cb;

@end
