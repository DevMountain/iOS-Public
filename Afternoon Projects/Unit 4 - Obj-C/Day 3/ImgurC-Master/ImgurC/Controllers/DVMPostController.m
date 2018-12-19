//  DVMPostController.m
//  ImgurC
//
//  Created by Jayden Garrick on 12/19/18.
//  Copyright © 2018 Jayden Garrick. All rights reserved.

#import "DVMPostController.h"
#import "DVMPost.h"

@implementation DVMPostController

// MARK: - Methods
+ (void)fetchPostsWithKeyword:(NSString *)keyword
                         page:(NSInteger)page
                   completion:(void (^)(NSArray<DVMPost *> *))completion
{
    // URL
    NSURL *baseUrl = [[NSURL alloc] initWithString:@"https://api.imgur.com/3/gallery/search/time"];
    
    NSString *pageNumberString = [NSString stringWithFormat:@"%ld", (long)page];
    NSURL *componentsUrl = [baseUrl URLByAppendingPathComponent: pageNumberString];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:componentsUrl resolvingAgainstBaseURL:YES];
    
    NSURLQueryItem *searchQuery = [[NSURLQueryItem alloc] initWithName:@"q" value:keyword];
    [urlComponents setQueryItems:@[searchQuery]];
    
    NSURL *searchUrl = [urlComponents URL];
    
    // Request
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:searchUrl];
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    [mutableRequest addValue:@"Client-ID e32d5d6830538ac" forHTTPHeaderField:@"Authorization"];
    request = [mutableRequest copy];
    
    // URLSessionDataTask
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"❌Error with URLDataTask: %@", error.localizedDescription);
            completion(nil);
            return;
        }
        if (data == nil) {
            NSLog(@"❌Error with URLDataTask: Unable to get Data from request");
            completion(nil);
            return;
        }
        
        NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSArray *postsArray = topLevelDictionary[@"data"];
        NSMutableArray *posts = [NSMutableArray new];
        
        for (NSDictionary *dictionary in postsArray) {
            DVMPost *post = [[DVMPost alloc] initWithDictionary:dictionary];
            [posts addObject:post];
        }
        completion(posts);
    }]resume];
}

@end
