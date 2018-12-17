//
//  DVMEntry.m
//  JournalC
//
//  Created by Jayden Garrick on 12/5/18.
//  Copyright © 2018 Jayden Garrick. All rights reserved.
//

#import "DVMEntry.h"

@implementation DVMEntry

// MARK: - Initialization
- (instancetype)initWithTitle:(NSString *)title text:(NSString *)text timestamp:(NSDate *)timestamp
{
    // Call super init
    self = [super init];
    if (self) {
        _title = title;
        _text = text;
        _timestamp = timestamp;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *title = dictionary[@"title"];
    NSString *text = dictionary[@"text"];
    NSDate *timestamp = dictionary[@"timestamp"];
    return [self initWithTitle:title text:text timestamp:timestamp];
}

// MARK: - Helpers
- (NSDictionary *)dictionaryRepresentation
{
    return @{
             @"title": self.title,
             @"text": self.text,
             @"timestamp": self.timestamp
             };
}

@end
