//
//  NomzTableViewCell.h
//  Nomz
//
//  Created by Guy Morita on 6/14/14.
//  Copyright (c) 2014 geemoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NomzTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *nomzMainImage;
@property (weak, nonatomic) IBOutlet UILabel *nomzPlaceName;
@property (weak, nonatomic) IBOutlet UIImageView *nomzStarRating;
@property (weak, nonatomic) IBOutlet UILabel *nomzAddress;
@property (weak, nonatomic) IBOutlet UILabel *nomzCategory;

@end
