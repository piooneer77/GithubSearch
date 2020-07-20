//
//  UserNetworkService.m
//  GithubUserSearch
//
//  Created by Karem Gohar on 17.07.20.
//  Copyright © 2020 Karem Gohar. All rights reserved.
//

#import "UserNetworkService.h"
#import "AFNetworking.h"


@implementation UserNetworkService 

- (void)getUsersList:(NSString *)searchString withCompletionHandler:(void (^)(NSArray<Repository *> * _Nullable, NSError * _Nullable))completionBlock {
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.github.com/users/%@/repos", searchString];
    NSURL *url = [NSURL URLWithString:urlString];
    
    [super fireListRequest:url withCompletionHandler:^(NSArray<id> * _Nullable list, NSError * _Nullable error) {

        NSArray<Repository *> *array = [[NSArray alloc] init];
        if (list != nil) {
            array = (NSArray<Repository *> *)[[NSArray alloc] initWithArray:list];
        }
        completionBlock(array, error);
    }];
    
}

@end

