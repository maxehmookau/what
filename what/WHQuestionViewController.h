//
//  WHQuestionViewController.h
//  what
//
//  Created by Max Woolf on 09/07/2013.
//  Copyright (c) 2013 maxwoolf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"
#import "FUIButton.h"

@interface WHQuestionViewController : UIViewController

@property (nonatomic) Question *question;
@property (nonatomic) IBOutlet UILabel *questionLbl;
@property (nonatomic) IBOutlet FUIButton *yesBtn;
@property (nonatomic) IBOutlet FUIButton *noBtn;

- (IBAction)didPressYesButton;
- (IBAction)didPressNoButton;
- (void)enableButtons;

@end
