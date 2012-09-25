//
//  Pagination.m
//  PaginationExample
//
//  Created by 张朝 on 11-1-24.
//  Copyright 2011 Lcduba. All rights reserved.
//

#import "Pagination.h"


@implementation Pagination
@synthesize currentPageNo;
@synthesize content;
@synthesize pageRanges;

- (NSArray *)pagingContentWithFont:(UIFont *)font inRect:(CGRect)r {
	NSMutableArray *ranges = [NSMutableArray array];
	UILineBreakMode lineBreakMode = UILineBreakModeCharacterWrap;
	CGFloat lineHeight = [@"Simple样本" sizeWithFont:font].height;
	NSInteger maxLine = floor(r.size.height / lineHeight);
	NSInteger totalLines = 0;
	NSString *lastParaLeft = nil;
	NSRange range = NSMakeRange(0, 0);
	
	NSArray *paragraphs = [content componentsSeparatedByString:@"\n"];
	for (int p = 0; p < [paragraphs count]; p++) {
		NSString *para;
		if (lastParaLeft) {
			para = lastParaLeft;
			lastParaLeft = nil;
		}else {
			para = [paragraphs objectAtIndex:p];
			if (p < [paragraphs count] - 1) {
				para = [para stringByAppendingFormat:@"\n"];
			}
		}
		
		CGSize paraSize = [para sizeWithFont:font constrainedToSize:r.size lineBreakMode:lineBreakMode];
		NSInteger paraLines = floor(paraSize.height / lineHeight);
		if (totalLines + paraLines < maxLine) {
			totalLines += paraLines;
			range.length += [para length];
			if (p == [paragraphs count] - 1) {
				NSLog(@"Pagination over!");
			}
		}else if (totalLines + paraLines == maxLine) {
			range.length += [para length];
			[ranges addObject:[NSValue valueWithRange:range]];
			range.location += range.length;
			range.length = 0;
			totalLines = 0;
		}else {
			NSInteger lineLeft = maxLine - totalLines;
			CGSize tmpSize;
			int i = 1;
			for (; i < [para length]; i++) {
				NSString *tmp = [para substringToIndex:i];
				tmpSize = [tmp sizeWithFont:font constrainedToSize:r.size lineBreakMode:lineBreakMode];
				int nowLine = floor(tmpSize.height / lineHeight);
				if (lineLeft < nowLine) {
					lastParaLeft = [para substringFromIndex:i-1];
					break;
				}
			}
			range.length += i - 1;
			[ranges addObject:[NSValue valueWithRange:range]];
			range.location += range.length;
			range.length = 0;
			totalLines = 0;
			p--;
		}
	}
	pageRanges = [[NSArray arrayWithArray:ranges] retain];
	
	return pageRanges;
}

- (NSInteger)totalPageCount {
	return [self.pageRanges count];
}

- (NSInteger)currentPageNo {
	if (currentPageNo <= 0) {
		currentPageNo = 1;
	}
	if (currentPageNo > self.totalPageCount) {
		currentPageNo = self.totalPageCount;
	}
	return currentPageNo;
}

- (NSString *)contentForPage:(NSInteger)pageNo {
	if (pageNo < 1 || pageNo > self.totalPageCount) {
		return nil;
	}
	NSValue *rangeValue = [pageRanges objectAtIndex:pageNo - 1];
	return [content substringWithRange:[rangeValue rangeValue]];
}

- (NSString *)contentForCurrentPage {
	return [self contentForPage:self.currentPageNo];
}

#pragma mark -
- (id)init {
	if (self = [super init]) {
		//
	}
	return self;
}

- (id)initWithContent:(NSString *)txtContent withFont:(UIFont *)font inRect:(CGRect)r {
	if(self = [self init]) {
		self.content = txtContent;
		[self pagingContentWithFont:font inRect:r];
		self.currentPageNo = 1;
	}
	return self;
}

- (void)dealloc {
	[content release];
	[pageRanges release];
	[super dealloc];
}

@end
