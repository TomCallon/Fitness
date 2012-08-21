//
//  VideoManager.m
//  WoJianMei
//
//  Created by Tom Callon on 8/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VideoManager.h"
#import "Video.h"
#define FOLLOW_VIDEO_LIST        @"FOLLOW_VIDEO_LIST"


VideoManager *videoManager;
extern VideoManager   *GlobalGetVideoManager()
{
    if (videoManager == nil) {
        videoManager = [[VideoManager alloc] init];
    }
    return videoManager;
}

@implementation VideoManager
@synthesize videoArray =_videoArray;
@synthesize  videoList = _videoList;
@synthesize followVideoList=_followVideoList;


+(VideoManager *)defaultManager{

    return GlobalGetVideoManager();

}

- (id)init
{
    self = [super init];    
    if (self) {
        
        _videoList = [[NSMutableArray alloc]init];
        
        _followVideoList =[[NSMutableDictionary alloc]init];
        
        _videoArray = [[NSArray alloc]init];

        [self loadFollowVideoList];
    }
    return self;
}


-(void)removeAllVideos{
    
    [self.videoList removeAllObjects];

}
-(void)addVideo:(Video *)video{
    
    if (video ==nil) {
        return;
    }
    [_videoList addObject:video];

}
-(void)removeVideo:(Video *)video{
    
    [_videoList removeObjectAtIndex:[video.videoId intValue]];
    

}
-(Video *)getVideoByWorkOutType:(NSInteger)VideoId{
    
    Video *video = [_videoList objectAtIndex:VideoId];
    
    
    return video;
}
-(void)addVideoWithId:(NSString*)aId
                title:(NSString *)aVideoTitle
            imageName:(NSString *)aImageName
            timeLeght:(NSString *)aTimeLenght   
             isFollow:(BOOL)aIsFollow
              workOut:(WorkOut*)aWorkOut{
    
    Video *video = [[Video alloc]initWithId:[NSString stringWithFormat:@"%d",[_videoList count]]
                                      title:aVideoTitle 
                                  timeLeght:aTimeLenght 
                                      image:[UIImage imageNamed:aImageName]
                                   isFollow:NO 
                                    workOut:aWorkOut];
    [_videoList addObject:video];
    [video release];

}
    
  
#pragma FOLLOW VIDEO
#pragma mark

- (void)loadFollowVideoList
{
    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
    NSData* listData = [userDefault objectForKey:FOLLOW_VIDEO_LIST];
    NSMutableDictionary *getFollowMatchList = [NSKeyedUnarchiver unarchiveObjectWithData:listData];
   [self.followVideoList setDictionary:getFollowMatchList];
}

- (void)saveFollowVideoList
{
    if (_followVideoList == nil)
        return;
    
    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
    NSData *followList = [NSKeyedArchiver archivedDataWithRootObject:_followVideoList];
    [userDefault setObject:followList forKey:FOLLOW_VIDEO_LIST];
    
}

- (void)followVideo:(Video*)video
{
    if (video == nil)
        return;
    
    [video setIsFollow:[NSNumber numberWithBool:YES]];
    if ([_followVideoList objectForKey:video.videoId] == nil){
        [self.followVideoList setObject:video forKey:video.videoId];
        [self saveFollowVideoList];
        NSLog(@"my follow videolist %@",[_followVideoList description]);
        NSLog(@"follow match (%@)", [video description]);
    }
    
}

- (void)unfollowVideo:(Video*)video
{
    if (video == nil)
        return;
    
    [video setIsFollow:[NSNumber numberWithBool:NO]];
    [_followVideoList removeObjectForKey:video.videoId];    
    [self saveFollowVideoList];
    
    NSLog(@"unfollow match (%@)", [video description]);
}

- (BOOL)isVideoFollowed:(Video*)video
{
    
    if (video.videoId == nil || _followVideoList == nil)
        return NO;
    return [_followVideoList objectForKey:video.videoId] != nil;
}



- (NSArray*)getAllFollowVideo
{     
    

    NSArray  *array = [_followVideoList allValues];
    
//    NSArray* sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        Video* video1 = (Video*)obj1;
//        Video* video2 = (Video*)obj2;
//        
//        NSComparisonResult result = [video1.status compare:video2.status];
//        if (result == NSOrderedSame) {
//            result = [video1.date compare:video2.date];
//            return result;
//        }
//        return -result;
//        
//    }];
    
    
//    return sortedArray;
    
    return array ;
}    

- (Video *)getVideoById:(NSString *)videoId
{
    if (videoId == nil) {
        return nil;
    }
    for (int i = 0; i < [_videoList count]; ++i) {
        Video *video = [_videoList objectAtIndex:i];
        if ([video.videoId isEqualToString:videoId]) {
            return video;
        }
    }
    return nil;
}

- (Video *)getFollowVideoById:(NSString *)videoId
{
    if (videoId == nil) {
        return nil;
    }
    for (Video* video in [_followVideoList allValues]) {
        if ([video.videoId isEqualToString:videoId]) {
            return video;
        }
    }
    return nil;
}

- (void)updateFollowVideo:(Video*)video
{
    Video *videoInFollow = [_followVideoList objectForKey:video.videoId];
    if (videoInFollow != nil) {
        [videoInFollow updateByVideo:video];
    }
}

-(void)dealloc{
    
    [_videoList release ];
    [_followVideoList release];
    [super dealloc];
    
}


@end
