//
//  ShopSettingData.h
//  FM
//
//  Created by T.N on 2014/02/01.
//  Copyright (c) 2014年 Nishida.Takahiro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ShopSettingDataEntity : NSManagedObject

@property (nonatomic, retain) NSString * storeName;
@property (nonatomic, retain) NSNumber * fee;
@property (nonatomic, retain) NSNumber * rate;

@end
