//
//  Question.m
//  what
//
//  Created by Max Woolf on 09/07/2013.
//  Copyright (c) 2013 maxwoolf. All rights reserved.
//

#import "Question.h"


@implementation Question

@dynamic yes;
@dynamic no;
@dynamic question;

- (NSString *)stringRepresentation
{
    return [NSString stringWithFormat:@"Question: %@\nYes: %@\nNo: %@", [self question], [self yes], [self no]];
}
@end
