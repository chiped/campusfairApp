//
//  StudentSpec.m
//  CampusfairApp
//
//  Created by Pednekar, Chinmay on 10/9/14.
//  Copyright (c) 2014 BarclayCardUS. All rights reserved.
//

#import "Kiwi.h"
#import "Student.h"

@interface Student()

- (Student *) initWithString:(NSString *)line;

@end

SPEC_BEGIN(StudentSpec)

describe(@"Student class", ^{
    
    __block Student *student = nil;
    
    beforeAll(^{
        NSString *line = @"First Name,Last Name,Email,Phone,Major,Minor,Subscribe";
        student = [[Student alloc] initWithString: line];
    });
    
    context(@"when first name is retrieved", ^{
        
        it(@"should match the first name from line", ^{
            
            [[student.firstName should] equal:@"First Name"];
        });
        
    });
    
    context(@"when last name is retrieved", ^{
        
        it(@"should match the last name from line", ^{
            
            [[student.lastName should] equal:@"Last Name"];
        });
        
    });
    
    context(@"when email is retrieved", ^{
        
        it(@"should match the email from line", ^{
            
            [[student.email should] equal:@"Email"];
        });
        
    });
    
    context(@"when phone is retrieved", ^{
        
        it(@"should match the phone from line", ^{
            
            [[student.phone should] equal:@"Phone"];
        });
        
    });
    
    context(@"when major is retrieved", ^{
        
        it(@"should match the major from line", ^{
            
            [[student.major should] equal:@"Major"];
        });
        
    });
    
    context(@"when minor is retrieved", ^{
        
        it(@"should match the minor from line", ^{
            
            [[student.minor should] equal:@"Minor"];
        });
        
    });
    
    context(@"when subscribe is retrieved", ^{
        
        it(@"should match the subscribe from line", ^{
            
            [[student.subscribe should] equal:@"Subscribe"];
        });
        
    });
    
});

SPEC_END
