//
//  DVMEntryController.m
//  JournalC
//
//  Created by Jayden Garrick on 12/6/18.
//  Copyright © 2018 Jayden Garrick. All rights reserved.
//

#import "DVMEntryController.h"

@implementation DVMEntryController


// MARK: - Properties
+ (DVMEntryController *)sharedController // Singleton
{
    static DVMEntryController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DVMEntryController alloc] init];
//        [sharedInstance loadFromPersistentStoreage];
    });
    return sharedInstance;
}

- (NSMutableArray *)entries
{
    return [NSMutableArray new];
}

// MARK: - CRUD
- (void)addEntry:(DVMEntry *)entry
{
    [self.entries addObject:entry];    
}

- (void)removeEntry:(DVMEntry *)entry
{
    [self.entries removeObject:entry];
}

- (void)modifyEntry:(DVMEntry *)entry withTitle:(NSString *)title text:(NSString *)text
{
    entry.title = title;
    entry.text = text;
}

@end
