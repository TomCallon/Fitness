//
//  WorkOut.m
//  WoJianMei
//
//  Created by Tom Callon on 8/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WorkOut.h"

@implementation WorkOut
@synthesize workOutTimeLength =_workOutTimeLength;
@synthesize sets =_sets;
@synthesize repeatTimes =_repeatTimes;




-(id)init{
   
    self = [super init];
    if (self) {
        //customrize
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.workOutTimeLength forKey:@"workOutTimeLength"];
    [aCoder encodeObject:self.sets forKey:@"sets"];
    [aCoder encodeObject:self.repeatTimes forKey:@"repeatTimes"];

}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
        self.workOutTimeLength =[aDecoder decodeObjectForKey:@"workOutTimeLength"];
        self.sets = [aDecoder decodeObjectForKey:@"sets"];
        self.repeatTimes = [aDecoder decodeObjectForKey:@"repeatTimes"];
    }
    return self;
}


-(void)dealloc{
    [_workOutTimeLength release];
    [_sets release];
    [_repeatTimes release];
    [super dealloc];
}

@end
