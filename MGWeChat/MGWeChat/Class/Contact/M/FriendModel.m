//
//  FriendModel.m
//  MGWeChat
//
//  Created by ming on 16/8/16.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "FriendModel.h"

@implementation FriendModel

+ (instancetype)friendModelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.userId      = dict[@"userId"];
        self.userName    = dict[@"userName"];
        self.photo       = dict[@"photo"];
        self.phoneNO     = dict[@"phoneNO"];
        
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
