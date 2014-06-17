//
//  FilterSwitchTableViewCell.h
//  Nomz
//
//  Created by Guy Morita on 6/16/14.
//  Copyright (c) 2014 geemoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NomzSwitch;

@interface FilterSwitchTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *filterBasicLabel;
@property (weak, nonatomic) IBOutlet NomzSwitch *filterBasicSwitch;

@end
