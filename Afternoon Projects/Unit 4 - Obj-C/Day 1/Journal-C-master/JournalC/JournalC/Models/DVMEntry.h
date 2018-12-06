//
//  DVMEntry.h
//  JournalC
//
//  Created by Jayden Garrick on 12/5/18.
//  Copyright © 2018 Jayden Garrick. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DVMEntry : NSObject

// MARK: - Properties
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *timestamp;

// MARK: - Initialization
- (instancetype) initWithTitle:(NSString *)title
                          text:(NSString *)text
                     timestamp:(NSDate *)timestamp;

@end

NS_ASSUME_NONNULL_END
