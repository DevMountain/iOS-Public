//
//  DVMEntryController.h
//  JournalC
//
//  Created by Jayden Garrick on 12/6/18.
//  Copyright © 2018 Jayden Garrick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DVMEntry.h"


@interface DVMEntryController : NSObject

// MARK: - Properties
+ (DVMEntryController *)sharedController;
@property (nonatomic, strong) NSMutableArray<DVMEntry*> *entries;

// MARK: - Methods
- (void)saveToPersistentStorage;
- (void)loadFromPersistentStorage;
- (void)addEntry:(DVMEntry *)entry;
- (void)removeEntry:(DVMEntry *)entry;
- (void)modifyEntry:(DVMEntry *)entry
              withTitle:(NSString *)title
               text:(NSString *)text;

@end


    
