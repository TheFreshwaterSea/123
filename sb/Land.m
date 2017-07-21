//
//  Land.m
//  GovRegulatory
//
//  Created by FreshWater on 17/7/4.
//  Copyright © 2017年 FreshWater. All rights reserved.
//

#import "Land.h"

@implementation Land
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString: @"id"]) {
        _ID = [value integerValue];
    }
    
}
@end
