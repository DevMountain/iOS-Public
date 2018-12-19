//
//  DVMImage.m
//  ImgurC
//
//  Created by Jayden Garrick on 12/19/18.
//  Copyright © 2018 Jayden Garrick. All rights reserved.
//

#import "DVMImage.h"

@implementation DVMImage

// MARK: - Initialization
- (instancetype)initWithImageUrlString:(NSString *)imageUrlString title:(NSString *)title imageDescription:(NSString *)imageDescription
{
    self = [super init];
    
    if (self) {
        _imageUrlString = imageUrlString;
        _title = title;
        _imageDescription = imageDescription;
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString *imageUrlString = dictionary[@"link"];
    NSString *title = dictionary[@"title"];
    NSString *imageDescription = dictionary[@"description"];
    
    return [self initWithImageUrlString:imageUrlString title:title imageDescription:imageDescription];
}

@end
