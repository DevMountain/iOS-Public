//
//  DVMCardController.m
//  DeckOfOneC
//
//  Created by Jayden Garrick on 12/17/18.
//  Copyright © 2018 Jayden Garrick. All rights reserved.
//

#import "DVMCardController.h"

@implementation DVMCardController

+ (void)drawCardWithCompletion:(void (^)(DVMCard *))completion
{
    // URL
    NSURL *url = [[NSURL alloc] initWithString:@"https://deckofcardsapi.com/api/deck/new/draw/?count=1"];
    
    // DataTask+Resume
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completion(nil);
            return;
        }
        if (data == nil) {
            completion(nil);
            return;
        }
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if (jsonDictionary == nil) {
            completion(nil);
            return;
        }
        DVMCard *card = [[DVMCard new] initWithDictionary:jsonDictionary];
        completion(card);
    }]resume];
}

+ (void)fetchCardImageWithCard:(DVMCard *)card completion:(void (^)(UIImage *))completion
{
    // URL
    NSURL *imageUrl = [[NSURL alloc]initWithString: [card imageUrlString]];
    
    // DataTask+Resume
    [[[NSURLSession sharedSession] dataTaskWithURL:imageUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completion(nil);
            return;
        }
        if (data == nil) {
            completion(nil);
            return;
        }
        UIImage *image = [[UIImage alloc]initWithData:data];
        completion(image);
    }]resume];

}

@end
