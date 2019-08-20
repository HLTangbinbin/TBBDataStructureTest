//
//  OneEntity.m
//  AwesomeProject
//
//  Created by tbb_mbp13 on 2019/8/16.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "OneEntity.h"
#import "PhoneEntity.h"

@implementation OneEntity
//MJExtensionCodingImplementation
+ (NSDictionary *)objectClassInArray
{
  return @{
           @"phone" : [PhoneEntity class],
           };
}
@end
