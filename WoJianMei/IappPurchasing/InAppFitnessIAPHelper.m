//
//  InAppRageIAPHelper.m
//  InAppRage
//
//  Created by Ray Wenderlich on 2/28/11.
//  Copyright 2011 Ray Wenderlich. All rights reserved.
//

#import "InAppFitnessIAPHelper.h"

@implementation InAppFitnessIAPHelper

static InAppFitnessIAPHelper * _sharedHelper;

+ (InAppFitnessIAPHelper *) sharedHelper {
    
    if (_sharedHelper != nil) {
        return _sharedHelper;
    }
    _sharedHelper = [[InAppFitnessIAPHelper alloc] init];
    return _sharedHelper;
    
}

- (id)init {
    
    NSSet *productIdentifiers = [NSSet setWithObjects:
        @"com.tomcallon.puppush.upperboddy",
        @"com.tomcallon.PopPush.zhonghuafitness",
        @"com.tomcallon.poppush.lowerboddy",
        nil];
    
    if ((self = [super initWithProductIdentifiers:productIdentifiers])) {                
        
    }
    return self;
    
}

@end
