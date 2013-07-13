//
//  WHQuestionViewController.m
//  what
//
//  Created by Max Woolf on 09/07/2013.
//  Copyright (c) 2013 maxwoolf. All rights reserved.
//

#import "WHQuestionViewController.h"
#import "UIFont+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "WHAppDelegate.h"

@interface WHQuestionViewController ()

@end

@implementation WHQuestionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor cloudsColor]];
    NSLog(@"%@", [_question stringRepresentation]);
    // Do any additional setup after loading the view from its nib.
    NSArray *buttons = [NSArray arrayWithObjects:_yesBtn, _noBtn, nil];
    for (FUIButton *button in buttons) {
        button.buttonColor = [UIColor turquoiseColor];
        button.shadowColor = [UIColor greenSeaColor];
        button.shadowHeight = 3.0f;
        button.cornerRadius = 6.0f;
        button.titleLabel.font = [UIFont boldSystemFontOfSize:32];
        [button setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    }
    
    [_questionLbl setText:[_question question]];
}

#pragma mark - Button presses

- (void)enableButtons
{
    [_yesBtn setEnabled:YES];
    [_noBtn setEnabled:YES];
}

- (void)didPressYesButton
{
    [_yesBtn setEnabled:NO];
    [_noBtn setEnabled:NO];
    [self performSelector:@selector(enableButtons) withObject:nil afterDelay:1.0];
    WHAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = [delegate managedObjectContext];
    NSNumber *yesVotes = [[self question] yes];
    [[self question] setYes:[NSNumber numberWithInt:[yesVotes intValue] + 1]];
    [moc save:nil];

}

- (void)didPressNoButton
{
    [_yesBtn setEnabled:NO];
    [_noBtn setEnabled:NO];
    [self performSelector:@selector(enableButtons) withObject:nil afterDelay:1.0];
    WHAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = [delegate managedObjectContext];
    NSNumber *noVotes = [[self question] no];
    [[self question] setNo:[NSNumber numberWithInt:[noVotes intValue] + 1]];
    [moc save:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:YES];
}

@end
