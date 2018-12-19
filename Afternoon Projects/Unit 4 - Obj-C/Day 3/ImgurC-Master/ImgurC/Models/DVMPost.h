//
//  DVMPost.h
//  ImgurC
//
//  Created by Jayden Garrick on 12/19/18.
//  Copyright © 2018 Jayden Garrick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DVMImage.h"

@interface DVMPost : NSObject

// MARK: - Properties
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, copy, readonly) NSArray<DVMImage*> *images;

// MARK: - Initialization
- (instancetype) initWithTitle:(NSString *)title
                    identifier:(NSString *)identifier
                        images:(NSArray<DVMImage*>*)images;

- (instancetype) initWithDictionary:(NSDictionary <NSString *,id>*)dictionary;

@end
