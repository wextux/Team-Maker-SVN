//
//  Thumbnail.m
//  TeamMakerPro
//
//  Created by Will Fairclough on 11-08-10.
//  Copyright (c) 2011 Superna. All rights reserved.
//

#import "Thumbnail.h"

@implementation Thumbnail

+ (Class)transformedValueClass 
{
    return [NSData class]; 
}

+ (BOOL)allowsReverseTransformation 
{
    return YES; 
}

- (id)transformedValue:(id)value 
{
    if (value == nil)
        return nil;
    
    // I pass in raw data when generating the image, save that directly to the database
    if ([value isKindOfClass:[NSData class]])
        return value;
    
    return UIImagePNGRepresentation((UIImage *)value);
}

- (id)reverseTransformedValue:(id)value
{
    return [UIImage imageWithData:(NSData *)value];
}



@end
