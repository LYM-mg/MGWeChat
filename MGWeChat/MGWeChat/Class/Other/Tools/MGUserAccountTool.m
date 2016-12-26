//
//  MGUserAccountTool.m
//  MGWeChat
//
//  Created by ming on 16/8/17.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGUserAccountTool.h"

@interface MGUserAccountTool ()<NSCoding>

@end

@implementation MGUserAccountTool

+ (instancetype)shareInstance{
    return [[self alloc] init];
}

- (instancetype)init{
    if (self = [super init]) {
        self.experise_in = @(24*60*60*3);
    }
    return self;
}

/**
 *  保存登录信息
 *
 *  @return 是否成功
 */
- (BOOL)saveAccount{
//    [[NSUserDefaults standardUserDefaults] objectForKey:@""]
    [NSKeyedArchiver archiveRootObject:self toFile:[@"Account.plist" document]];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[@"Account.plist" document]];
}

- (BOOL)isUserLogin{
    // 是否已经登录
    if ([NSKeyedUnarchiver unarchiveObjectWithFile:[@"Account.plist" document]] == nil){
        return NO;
    }
    
    // 登录是否过期
    if ([[NSDate date] compare:self.experise_date] == NSOrderedAscending) {
        return NO;
    }
    
    return YES;
}

- (void)setExperise_in:(NSNumber *)experise_in{
    _experise_in = experise_in;
}

- (void)setExperise_date:(NSDate *)experise_date{
    _experise_date = experise_date;
    self.experise_date = [NSDate dateWithTimeIntervalSinceNow:self.experise_in.doubleValue];
}


#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.accountName = [aDecoder decodeObjectForKey:@"accountName"];
        self.password = [aDecoder decodeObjectForKey:@"accountName"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.accountName forKey:@"accountName"];
    [aCoder encodeObject:self.password forKey:@"password"];
}

@end
