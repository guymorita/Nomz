//
//  YelpManager.m
//  Nomz
//
//  Created by Guy Morita on 6/16/14.
//  Copyright (c) 2014 geemoo. All rights reserved.
//

#import "YelpManager.h"
#import "YelpClient.h"

NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface YelpManager()

@property (strong, nonatomic) YelpClient *client;

@end

@implementation YelpManager

//- (id)init {
//    self = [super init];
//    if (self) {
//
//        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
//    }
//    return self;
//}
//
//+ (instancetype)sharedManager {
//    static id _sharedManager = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _sharedManager = [[self alloc] init];
//    });
//    
//    return _sharedManager;
//}

- (void)searchTermWithFilters:(NSString *)searchTerm {

    
//    [self.client searchWithTerm:searchTerm success:^(AFHTTPRequestOperation *operation, id response) {
//        self.yelpResponse = response;
//        self.yelpBusinesses = self.yelpResponse[@"businesses"];
//        NSLog(@"%@", response);
//        [self.nomzTableView reloadData];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"error: %@", [error description]);
//    }];
    
}

@end
