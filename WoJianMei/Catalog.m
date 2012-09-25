//
//  Catalog.m
//  MBook
//
//  Created by  on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Catalog.h"

@implementation Catalog
@synthesize chapter = _chapter;
@synthesize index = _index;

+ (Catalog *)catalogWithIndex:(NSInteger)index chapter:(NSString *)chapter
{
    return [[[Catalog alloc] initWithIndex:index chapter:chapter] autorelease];
}

- (id)initWithIndex:(NSInteger)index chapter:(NSString *)chapter
{
    self = [super init];
    if(self)
    {
        self.index = index;
        self.chapter = chapter;
    }
    return self;
}

- (void)dealloc
{
    [_chapter release];
    [super dealloc];
}
@end
