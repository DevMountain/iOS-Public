//
//  Card.m
//  DeckOfOneC
//
//  Created by Jayden Garrick on 12/17/18.
//  Copyright © 2018 Jayden Garrick. All rights reserved.
//

#import "DVMCard.h"

@implementation DVMCard

// MARK: - Initialization
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self) {
        NSArray *cards = dictionary[@"cards"];
        NSDictionary *cardDictionary = cards.firstObject;
        NSString *imageURlAsString = cardDictionary[@"image"];
        _imageUrlString = imageURlAsString;
    }
    return self;
}

@end
