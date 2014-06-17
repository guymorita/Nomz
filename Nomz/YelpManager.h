//
//  YelpManager.h
//  Nomz
//
//  Created by Guy Morita on 6/16/14.
//  Copyright (c) 2014 geemoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YelpManager : NSObject
+ (instancetype)sharedManager;
- (void)searchTermWithFilters:(NSString *)searchTerm;
@end
