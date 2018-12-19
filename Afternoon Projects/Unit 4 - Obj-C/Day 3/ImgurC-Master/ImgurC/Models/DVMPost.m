//
//  DVMPost.m
//  ImgurC
//
//  Created by Jayden Garrick on 12/19/18.
//  Copyright © 2018 Jayden Garrick. All rights reserved.
//

#import "DVMPost.h"

@implementation DVMPost
// MARK: - Initialization
- (instancetype)initWithTitle:(NSString *)title identifier:(NSString *)identifier images:(NSArray<DVMImage *> *)images
{
    self = [super init];
    if (self) {
        _title = title;
        _identifier = identifier;
        _images = images;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString *title = dictionary[@"title"];
    NSString *identifier = dictionary[@"id"];
    NSMutableArray *images = [NSMutableArray new];
    
    NSArray *imagesArray = dictionary[@"images"];
    
    for (NSDictionary *dictionary in imagesArray) {
        DVMImage *image = [[DVMImage alloc] initWithDictionary:dictionary];
        [images addObject:image];
    }
    
    return [self initWithTitle:title identifier:identifier images:images];
}

@end
