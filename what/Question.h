//
//  Question.h
//  what
//
//  Created by Max Woolf on 09/07/2013.
//  Copyright (c) 2013 maxwoolf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Question : NSManagedObject

@property (nonatomic, retain) NSNumber * yes;
@property (nonatomic, retain) NSNumber * no;
@property (nonatomic, retain) NSString * question;

@end
