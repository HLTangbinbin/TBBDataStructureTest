//
//  PhoneEntity.h
//  AwesomeProject
//
//  Created by tbb_mbp13 on 2019/8/16.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "BaseEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhoneEntity : BaseEntity
@property (nonatomic,copy) NSString *size;
@property (nonatomic,copy) NSString *type;
@end

NS_ASSUME_NONNULL_END
