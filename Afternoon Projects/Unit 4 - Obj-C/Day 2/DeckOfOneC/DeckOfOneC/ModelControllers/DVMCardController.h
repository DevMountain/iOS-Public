//
//  DVMCardController.h
//  DeckOfOneC
//
//  Created by Jayden Garrick on 12/17/18.
//  Copyright © 2018 Jayden Garrick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DVMCard.h"


@interface DVMCardController : NSObject

+ (void) drawCardWithCompletion: (void (^) (DVMCard *)) completion;
+ (void) fetchCardImageWithCard: (DVMCard *) card completion: (void (^) (UIImage *)) completion;

@end

