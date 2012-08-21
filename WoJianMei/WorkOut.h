//
//  WorkOut.h
//  WoJianMei
//
//  Created by Tom Callon on 8/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkOut : NSObject<NSCoding>
{

    NSString *_workOutTimeLength;
    NSString *_repeatTimes;
    NSString *_sets;
    
    

}

@property (retain ,nonatomic)  NSString *workOutTimeLength;
@property (retain, nonatomic)  NSString *repeatTimes;
@property (retain, nonatomic)  NSString *sets;


@end
