//
//  WeiBoManager.m
//  WoJianMei
//
//  Created by Tom Callon  on 9/21/12.
//
//

#import "WeiBoManager.h"

@implementation WeiBoManager


/////定义全局变量
WeiBoManager *weiBoManager = nil;
extern WeiBoManager   *GlobalGetWeiBoManager()
{
    if (weiBoManager == nil) {
        weiBoManager = [[WeiBoManager alloc] init];
    }
    return weiBoManager;
}

+(WeiBoManager *)defaultManager{
    return GlobalGetVideoManager();
}


@end
