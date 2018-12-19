//
//  DVMPostController.h
//  ImgurC
//
//  Created by Jayden Garrick on 12/19/18.
//  Copyright © 2018 Jayden Garrick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DVMPost.h"

@interface DVMPostController : NSObject

// MARK: - Methods
+ (void) fetchPostsWithKeyword: (NSString *)keyword
                          page: (NSInteger) page
                    completion: (void (^) (NSArray<DVMPost*>*))completion;

@end
