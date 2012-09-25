//
//  Link.m
//  MBook
//
//  Created by  on 12-7-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Link.h"

@implementation Link
@synthesize range = _range;
@synthesize type = _type;
@synthesize linkId = _linkId;
@synthesize name = _name;
#define PREFIX_MUSIC @"<music://"
#define PREFIX_VIDEO @"<video://"


- (void)dealloc
{
    [_name release];
    [super dealloc];
}

+ (Link *)paserLink:(NSString *)string prefix:(NSString *)prefix
{
    NSRange rangeMusic = [string rangeOfString:prefix];    
    if (rangeMusic.location != NSNotFound) {
        int i = rangeMusic.location + prefix.length;
        int start = i;
        int tagEnd = 0;
        for (; i < string.length; ++ i) {
            if ([string characterAtIndex:i] == '>') {
                tagEnd = i;
                break;
            }
        }
        if (tagEnd != 0) {
            NSRange range = NSMakeRange(start, tagEnd - start);
            NSString * linkIdString = [string substringWithRange:range];
            NSInteger value = [linkIdString integerValue];
            
            Link *link = [[[Link alloc] init] autorelease];
            rangeMusic.length = tagEnd - rangeMusic.location + 1;
            link.range = rangeMusic;
            link.linkId = value;
            link.name = linkIdString;
            if ([prefix isEqualToString:PREFIX_MUSIC]) {
                link.type = LinkTypeMusic;                
            }else{
                link.type = LinkTypeVideo;
            }
            return link;
        }else{
            return nil;
        }
    }
    return nil;
}

+ (Link *)paserMusicLink:(NSString *)string
{
    return [Link paserLink:string prefix:PREFIX_MUSIC];
}

+ (Link *)paserVideoLink:(NSString *)string
{
    return [Link paserLink:string prefix:PREFIX_VIDEO];
}

+ (Link *)linkWithString:(NSString *)string
{
        Link *linkMusic = [Link paserMusicLink:string];
        Link *linkViedo = [Link paserVideoLink:string];
        if (linkMusic == nil) {
            return linkViedo;
        }else if(linkViedo == nil)
        {
            return linkMusic;
        }else{
            if (linkMusic.range.location < linkViedo.range.location) {
                return linkMusic;
            }else{
                return linkViedo;
            }
        }
    return nil;
}

+ (NSString *)replaceRangeString:(NSString *)string withLink:(Link *)link
{
    NSString * sub1 = [string substringToIndex:link.range.location];
    NSInteger loc = link.range.location + link.range.length;
    NSString * sub2 = [string substringFromIndex:loc];
    NSString *temp = [NSString stringWithFormat:@"%@%@",sub1,sub2];
    return temp;
}
@end
