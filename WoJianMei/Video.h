//
//  Video.h
//  WoJianMei
//
//  Created by Tom Callon on 8/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WorkOut;

@interface Video : NSObject<NSCoding>

{

    NSString     *_videoId;
    NSString       *_title;
    UIImage        *_image;
    NSString  *_timeLength;
    WorkOut      *_workOut;
    NSNumber    *_isFollow;
    
    
    
}
@property (nonatomic, retain) NSString   *videoId;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) UIImage * image;
@property (nonatomic, retain) NSString *timeLenght;
@property (nonatomic, retain) WorkOut *workOut;
@property (retain, nonatomic) NSNumber       *isFollow;

-(id)initWithId:(NSString*)aId
          title:(NSString*)atitle 
      timeLeght:(NSString *)aTimeLenght 
          image:(UIImage *)aImage  
       isFollow:(BOOL)aIsFollow
        workOut:(WorkOut*)aWorkOut;
- (void)updateByVideo:(Video *)video;

@end
