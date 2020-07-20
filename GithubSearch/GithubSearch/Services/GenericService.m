//
//  GenericService.m
//  GithubUserSearch
//
//  Created by Karem Gohar on 18.07.20.
//  Copyright © 2020 Karem Gohar. All rights reserved.
//

#import "GenericService.h"
#import "AFNetworking/AFNetworking.h"

@implementation GenericService

- (void)fireListRequest:(NSURL *)url withCompletionHandler:(void (^)(NSArray<id<ResponseProtocol>> * _Nullable, NSError * _Nullable))completionBlock {
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        if (error != nil) {
            completionBlock(nil, error);
        } else {
            if (response != nil) {
                NSArray<id<ResponseProtocol>> *array = [self buildResponseFrom: data];
                completionBlock(array, nil);
            }
        }
    }];
    [dataTask resume];
}

- (NSArray<id<ResponseProtocol>> *)buildResponseFrom: (NSData *)data {
    NSMutableArray<id<ResponseProtocol>> *array = [[NSMutableArray alloc] init];
    NSDictionary* dictionaries = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    for (NSDictionary* dictionary in dictionaries) {
        id<ResponseProtocol> element = (id<ResponseProtocol>)[[NSObject alloc] init];
        element = (id<ResponseProtocol>)[element initWithJSONDictionary:dictionary];
        [array addObject:element];
    }
    return array;
}

@end
