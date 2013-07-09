//
//  WHQuestionListViewController.h
//  what
//
//  Created by Max Woolf on 09/07/2013.
//  Copyright (c) 2013 maxwoolf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHQuestionListViewController : UITableViewController <UIAlertViewDelegate>
{
    NSMutableArray *results;
}

- (void)promptForNewQuestion;
@end
