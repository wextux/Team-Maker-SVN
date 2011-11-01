//
//  PlayerCell.m
//  TeamMakerPro
//
//  Created by Will Fairclough on 11-08-15.
//  Copyright (c) 2011 Superna. All rights reserved.
//

#import "PlayerCell.h"

@implementation PlayerCell
@synthesize textLabel, detailLabel, thumbnailImage;


- (void)setUseDarkBackground:(BOOL)flag
{
    if (flag != useDarkBackground || !self.backgroundView)
    {
        useDarkBackground = flag;
        
        NSString *backgroundImagePath = [[NSBundle mainBundle] pathForResource:useDarkBackground ? @"cell_background" : @"LightBackground" ofType:@"png"];
        UIImage *backgroundImage = [[UIImage imageWithContentsOfFile:backgroundImagePath] stretchableImageWithLeftCapWidth:0.0 topCapHeight:1.0];
        self.backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.backgroundView.frame = self.bounds;
    }
}

- (BOOL)useDarkBackground
{
    return useDarkBackground;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}


#pragma mark - View lifecycle

- (void)awakeFromNib
{
    [super awakeFromNib];
}


@end
