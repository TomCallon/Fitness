//
//  Catalog.h
//  MBook
//
//  Created by  on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Catalog : NSObject
{
    NSInteger _index;
    NSString *_chapter;
}

@property(nonatomic, assign)NSInteger index;
@property(nonatomic, retain)NSString *chapter;

- (id)initWithIndex:(NSInteger)index chapter:(NSString *)chapter;
+ (Catalog *)catalogWithIndex:(NSInteger)index chapter:(NSString *)chapter;
@end
