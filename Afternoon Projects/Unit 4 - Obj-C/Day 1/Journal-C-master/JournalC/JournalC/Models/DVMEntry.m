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

@end
