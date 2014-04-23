//
//  PlayData.h
//  FM
//
//  Created by T.N on 2014/02/01.
//  Copyright (c) 2014年 Nishida.Takahiro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PlayData : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * firstRank;
@property (nonatomic, retain) NSString * thirdRank;
@property (nonatomic, retain) NSString * secondRank;
@property (nonatomic, retain) NSString * fourthRank;
@property (nonatomic, retain) NSNumber * balanceTotal;
@property (nonatomic, retain) NSString * storeName;

@end
