//
//  VideoManager.h
//  WoJianMei
//
//  Created by Tom Callon on 8/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Video;
@class WorkOut;


@interface VideoManager : NSObject

{
    NSArray *_videoArray;

    NSMutableArray  *_videoList;
    NSMutableDictionary *_followVideoList;

}
@property (nonatomic,retain) NSArray*          videoArray;
@property (nonatomic,retain) NSMutableArray *videoList;
@property (nonatomic,retain) NSMutableDictionary *followVideoList;


+(VideoManager *)defaultManager;



-(void)removeAllVideos;
-(void)addVideo:(Video *)video;
-(void)removeVideo:(Video *)video;
-(Video *)getVideoByWorkOutType:(NSInteger)VideoId;
-(void)addVideoWithId:(NSString*)aId
                title:(NSString *)aVideoTitle
            imageName:(NSString *)aImageName
            timeLeght:(NSString *)aTimeLenght   
             isFollow:(BOOL)aIsFollow
              workOut:(WorkOut*)aWorkOut;



- (Video *)getVideoById:(NSString *)videoId;
- (Video *)getFollowVideoById:(NSString *)videoId;



- (void)loadFollowVideoList;
- (void)saveFollowVideoList;
- (void)followVideo:(Video*)video;
- (void)unfollowVideo:(Video*)video;
- (BOOL)isVideoFollowed:(NSString*)videoId;

- (NSArray*)getAllFollowVideo;



extern  VideoManager *GlobalGetVideoManager();

@end
