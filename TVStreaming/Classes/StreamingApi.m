//
//  StreamingApi.m
//  TVStreaming
//
//  Created by Gilang Esha Gautama on 12/18/12.
//  Copyright (c) 2012 ___GILANGGAUTAMA___. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define API_CLIENT_URL @"http://api.anonim.jit.su/streaming_app/1.0"

#import "StreamingApi.h"

@implementation StreamingApi

-(void) getAllStationsWithCallback:(void (^)(NSDictionary *))cb
{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", API_CLIENT_URL, @"station"];
    
    [self executeApiWithUrl:url callback:cb];  
    
}

-(void) getAllCountriesWithCallback:(void(^)(NSDictionary*))cb
{
    NSString *url = [NSString stringWithFormat:@"%@/%@", API_CLIENT_URL, @"country"];
    
    
    [self executeApiWithUrl:url callback:cb];    
}


- (void) getStationsByCountry:(NSString *)countryId withCallback:(void (^)(NSDictionary *))cb
{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@",API_CLIENT_URL, @"stations/bycountry", countryId];
    
    [self executeApiWithUrl:url callback:cb];
    
}

- (void) getServersByStation:(NSString *)stationId withCallback:(void (^)(NSDictionary *))cb
{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@",API_CLIENT_URL, @"servers/bystation", stationId];
    
    [self executeApiWithUrl:url callback:cb];
    
}


- (void) executeApiWithUrl:(NSString*)url callback:(void(^)(NSDictionary*))cb
{
    //Formulate the string as a URL object.
    NSURL *requestURL=[NSURL URLWithString:url];
    
    // Retrieve the results of the URL.
    dispatch_async(kBgQueue, ^{
        NSLog(@"masuk async");
        
        NSData* data = [NSData dataWithContentsOfURL: requestURL];
        
        if(data == NULL)
        {
            NSLog(@"something wrong with API");
            
            NSDictionary * response = @{@"stat": @"fail", @"code":@"0", @"message":@"API can not be contacted"};
            
            dispatch_async(dispatch_get_main_queue(), ^{
                cb(response);
            });
            
        }
        else
        {
            NSError* error;
            NSDictionary* results = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error]; //1
            
            //NSArray* venues = [json objectForKey:@"pois"]; //2
            
            dispatch_async(dispatch_get_main_queue(), ^{
                cb(results);
            });
        }
        
        
    });
}

- (void) executeWaitApiWithUrl:(NSString*)url callback:(void(^)(NSDictionary*))cb
{
    //Formulate the string as a URL object.
    NSURL *requestURL=[NSURL URLWithString:url];
    
    // Retrieve the results of the URL.
        NSLog(@"masuk async");
        
        NSData* data = [NSData dataWithContentsOfURL: requestURL];
        
        if(data == NULL)
        {
            NSLog(@"something wrong with API");
            
            NSDictionary * response = @{@"stat": @"fail", @"code":@"0", @"message":@"API can not be contacted"};
            
            cb(response);
        
            
        }
        else
        {
            NSError* error;
            NSDictionary* results = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error]; //1
            
            //NSArray* venues = [json objectForKey:@"pois"]; //2
            
            
            cb(results);
            
        }
}

@end
