//
//  Pagination.h
//  PaginationExample
//
//  Created by 张朝 on 11-1-24.
//  Copyright 2011 Lcduba. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Pagination : NSObject {

	NSInteger currentPageNo;
	NSString *content;
	NSArray *pageRanges;
	
}

@property (nonatomic, readonly) NSInteger totalPageCount;
@property (nonatomic, assign) NSInteger currentPageNo;
@property (nonatomic, retain) NSString *content;
@property (nonatomic, readonly) NSArray *pageRanges;

- (id)initWithContent:(NSString *)txtContent withFont:(UIFont *)font inRect:(CGRect)r;
- (NSString *)contentForPage:(NSInteger)pageNo;
- (NSString *)contentForCurrentPage;

@end
