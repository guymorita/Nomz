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
    NSMutableDictionary *parameters = [self parseFilters:filterParameters];
    
    [parameters setObject:@"San Francisco" forKey:@"location"];
    [parameters setObject:term forKey:@"term"];

    
    // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
//    NSDictionary *parameters = @{@"term": term, @"location" : @"San Francisco"};
    NSLog(@"dict %@", parameters);

    return [self GET:@"search" parameters:parameters success:success failure:failure];
}

- (NSMutableDictionary *)parseFilters:(NSArray *)filterParameters {
    NSMutableDictionary *yelpFilters = [[NSMutableDictionary alloc] init];
    int i;
    for (i = 0; i < [filterParameters count]; i++){
        NSDictionary *dict = filterParameters[i];
        NSNumber *selected = dict[@"selected"];
        NSInteger selectedInt = [selected integerValue];
        NSString *selectedStr = filterParameters[i][@"contents"][selectedInt];
        
        switch (i) {
            case 0: {
                if ([dict[@"value"] isEqualToNumber:@(1)]){
                    [yelpFilters setObject:@"true" forKey:@"deals_filter"];
                }
                break;
            }
            case 1: {
                NSArray *cuisine = @[@"newamerican", @"asianfusion", @"bbq", @"breakfast_brunch", @"burmese", @"chinese", @"dimsum", @"creperies"];
                [yelpFilters setObject:cuisine[selectedInt] forKey:@"category_filter"];
                break;
            }
            case 2: {
                NSArray *distance = @[@"50", @"250", @"1000", @"5000", @"25000"];
                [yelpFilters setObject:distance[selectedInt] forKey:@"radius_filter"];
                break;
            }
            case 3: {
                [yelpFilters setObject:[selected stringValue] forKey:@"sort"];
                break;
            }
                
        }
    }
    return yelpFilters;
    
}

@end
