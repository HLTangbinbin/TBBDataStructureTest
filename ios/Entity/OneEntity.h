//
//  OneEntity.h
//  AwesomeProject
//
//  Created by tbb_mbp13 on 2019/8/16.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "BaseEntity.h"
#import "PhoneEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface OneEntity : BaseEntity
@property (nonatomic,copy) NSString *age;
@property (nonatomic,strong) PhoneEntity *computer;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSArray *phone;
@property (nonatomic,copy) NSString *rich;
@property (nonatomic,assign) NSInteger sex;
@end

NS_ASSUME_NONNULL_END
