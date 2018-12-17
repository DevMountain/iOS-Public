//
//  Card.h
//  DeckOfOneC
//
//  Created by Jayden Garrick on 12/17/18.
//  Copyright © 2018 Jayden Garrick. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DVMCard : NSObject

// MARK: - Properties
@property (nonatomic, strong) NSString *imageUrlString;

// MARK: - Initialization
- (instancetype) initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
