//
//  PlayerCell.h
//  TeamMakerPro
//
//  Created by Will Fairclough on 11-08-15.
//  Copyright (c) 2011 Superna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerCell : UITableViewCell {
    BOOL useDarkBackground;
}

@property BOOL useDarkBackground;
@property (nonatomic, strong) IBOutlet UILabel *textLabel;
@property (nonatomic, strong) IBOutlet UILabel *detailLabel;
@property (nonatomic, strong) IBOutlet UIImageView *thumbnailImage;

@end
