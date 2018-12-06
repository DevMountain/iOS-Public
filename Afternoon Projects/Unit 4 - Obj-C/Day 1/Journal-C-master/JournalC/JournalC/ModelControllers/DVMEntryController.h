//
//  DVMEntryController.h
//  JournalC
//
//  Created by Jayden Garrick on 12/6/18.
//  Copyright © 2018 Jayden Garrick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DVMEntry.h"

NS_ASSUME_NONNULL_BEGIN

@interface DVMEntryController : NSObject

// MARK: - Properties
+ (DVMEntryController *)sharedController;
@property (nonatomic, strong, readonly) NSArray *entries;

// MARK: - Methods
- (void)saveToPersistentStorage;
- (void)addEntry:(DVMEntry *)entry;
- (void)removeEntry:(DVMEntry *)entry;

@end

NS_ASSUME_NONNULL_END
