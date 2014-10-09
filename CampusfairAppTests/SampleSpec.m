//
//  SampleSpec.m
//  CampusfairApp
//
//  Created by Pednekar, Chinmay on 10/9/14.
//  Copyright (c) 2014 BarclayCardUS. All rights reserved.
//

#import "Kiwi.h"

SPEC_BEGIN(MathSpec)

describe(@"Math", ^{
    it(@"is pretty cool", ^{
        [[[NSNumber numberWithInt:43] should] equal:theValue(43)];
    });
});

SPEC_END