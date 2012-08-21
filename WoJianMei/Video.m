//
//  Video.m
//  WoJianMei
//
//  Created by Tom Callon on 8/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Video.h"

@implementation Video

@synthesize  videoId =_videoId;
@synthesize image =_image;
@synthesize title =_title;
@synthesize timeLenght =_timeLength;
@synthesize workOut =_workOut;
@synthesize isFollow =_isFollow;


-(id)initWithId:(NSString*)aId
          title:(NSString*)atitle 
      timeLeght:(NSString *)aTimeLenght 
          image:(UIImage *)aImage  
       isFollow:(BOOL)aIsFollow
        workOut:(WorkOut*)aWorkOut
{
    self = [super init];
    if (self) {
        self.videoId =aId;
        self.title = atitle;
        self.timeLenght=aTimeLenght;
        self.image = aImage;
        self.workOut = aWorkOut;
        self.isFollow = [NSNumber numberWithBool:aIsFollow];
    }

    return  self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.videoId forKey:@"videoId"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.timeLenght forKey:@"timeLenght"];
    [aCoder encodeObject:self.image forKey:@"image"];
    [aCoder encodeObject:self.workOut forKey:@"workOut"];
    [aCoder encodeObject:self.isFollow forKey:@"isFollow"];

}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self=[super init]) {
        self.videoId =[aDecoder decodeObjectForKey:@"videoId"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.timeLenght =[aDecoder decodeObjectForKey:@"timeLenght"];
        self.image = [aDecoder decodeObjectForKey:@"image"];
        self.workOut = [aDecoder decodeObjectForKey:@"workOut"];
        self.isFollow = [aDecoder decodeObjectForKey:@"isFollow"];
    }
    return self;
}


- (void)updateByVideo:(Video *)video
{
    self.videoId = video.videoId;
    self.title =video.title;
    self.timeLenght = video.timeLenght;
    self.image =video.image;
    self.workOut = video.workOut;
    self.isFollow =video.isFollow;

}

-(void)dealloc{

    [_videoId release];
    [_image release];
    [_title release];
    [_timeLength release];
    [_workOut release];
    [_isFollow release];
    [super dealloc];

}


@end
