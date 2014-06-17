//
//  YelpClient.m
//  Nomz
//
//  Created by Guy Morita on 6/14/14.
//  Copyright (c) 2014 geemoo. All rights reserved.
//

#import "YelpClient.h"

@implementation YelpClient

- (id)initWithConsumerKey:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret accessToken:(NSString *)accessToken accessSecret:(NSString *)accessSecret {
    NSURL *baseURL = [NSURL URLWithString:@"http://api.yelp.com/v2/"];
    self = [super initWithBaseURL:baseURL consumerKey:consumerKey consumerSecret:consumerSecret];
    if (self) {
        BDBOAuthToken *token = [BDBOAuthToken tokenWithToken:accessToken secret:accessSecret expiration:nil];
        [self.requestSerializer saveAccessToken:token];
    }
    return self;
}

- (AFHTTPRequestOperation *)searchWithTerm:(NSString *)term searchWithParameters:(NSArray *)filterParameters success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
//    NSLog(@"%@", filterParameters);
//    [self parseFilters:filterParameters];
    
    // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
    NSDictionary *parameters = @{@"term": term, @"location" : @"San Francisco"};
    
    return [self GET:@"search" parameters:parameters success:success failure:failure];
}

//- (NSMutableDictionary *)parseFilters:(NSArray *)filterParameters {
//    NSMutableDictionary *yelpFilters = [[NSMutableDictionary alloc] init];
//    int i;
//    for (i = 0; i < [filterParameters count]; i++){
//        switch (i) {
//            case 1: {
//                
//            }
//            case
//                
//        }
//    }
//    [yelpFilters setObject:@"bye" forKey:@"hi"];
//    NSLog(@"dict %@", yelpFilters);
//    return yelpFilters;
//    
//}

@end
