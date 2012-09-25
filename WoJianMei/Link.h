//
//  Link.h
//  MBook
//
//  Created by  on 12-7-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum{
    LinkTypeMusic = 0x1,
    LinkTypeVideo = 0x1 << 1
}
LinkType;

@interface Link : NSObject
{
    NSRange _range;
    NSInteger _type;
    NSInteger _linkId;
    NSString *_name;
}
+ (Link *)linkWithString:(NSString *)string;

@property(nonatomic, assign)NSRange range;
@property(nonatomic, assign)NSInteger type;
@property(nonatomic, assign)NSInteger linkId;
@property(nonatomic, retain)NSString *name;

+ (NSString *)replaceRangeString:(NSString *)string withLink:(Link *)link;

@end
