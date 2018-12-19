//
//  DVMImage.h
//  ImgurC
//
//  Created by Jayden Garrick on 12/19/18.
//  Copyright © 2018 Jayden Garrick. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DVMImage : NSObject

// MARK: - Properties
@property (nonatomic, copy, readonly) NSString *imageUrlString;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *imageDescription;


// MARK: - Initialization
- (instancetype) initWithImageUrlString:(NSString *)imageUrlString
                                  title:(NSString *)title
                       imageDescription:(NSString *)imageDescription;

- (instancetype) initWithDictionary:(NSDictionary<NSString*,id>*)dictionary;

@end
