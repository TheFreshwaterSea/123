//
//  Land.h
//  GovRegulatory
//
//  Created by FreshWater on 17/7/4.
//  Copyright © 2017年 FreshWater. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Land : NSObject
@property(nonatomic,assign)NSInteger ID;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *companyName;
@property(nonatomic,strong)NSString *principal;
@property(nonatomic,strong)NSString *location;
@property(nonatomic,strong)NSString *licenseUrl;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *certFlag;
@property(nonatomic,strong)NSString *testWay;
@property(nonatomic,strong)NSString *phone;

@end
