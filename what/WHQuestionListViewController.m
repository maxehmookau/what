//
//  WHQuestionListViewController.m
//  what
//
//  Created by Max Woolf on 09/07/2013.
//  Copyright (c) 2013 maxwoolf. All rights reserved.
//

#import "WHQuestionListViewController.h"
#import "WHQuestionViewController.h"
#import "UIFont+FlatUI.h"
#import "WHAppDelegate.h"
#import "Question.h"

@interface WHQuestionListViewController ()

@end

@implementation WHQuestionListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSFetchRequest *req = [NSFetchRequest new];
    WHAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *
    moc = [delegate managedObjectContext];
    NSEntityDescription *desc = [NSEntityDescription entityForName:@"Question" inManagedObjectContext:moc];
    [req setEntity:desc];
    results = [[moc executeFetchRequest:req
                                  error:nil] mutableCopy];

    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                               target:self
                                                                               action:@selector(promptForNewQuestion)];
    [self.navigationItem setRightBarButtonItem:addButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)promptForNewQuestion
{
    UIAlertView *questionInput = [UIAlertView new];
    [questionInput setAlertViewStyle: UIAlertViewStylePlainTextInput];
    [questionInput setTitle:@"New Question"];
    
    [questionInput addButtonWithTitle:@"Cancel"];
    [questionInput addButtonWithTitle:@"Add"];
    [questionInput setCancelButtonIndex:0];
    [questionInput show];
    [questionInput setDelegate:self];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        WHAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *moc = [delegate managedObjectContext];
        NSEntityDescription *desc = [NSEntityDescription entityForName:@"Question"
                                                inManagedObjectContext:moc];
        
        Question *question = [[Question alloc] initWithEntity:desc
                               insertIntoManagedObjectContext:moc];
        
        [question setQuestion:[[alertView textFieldAtIndex:0] text]];
        [results addObject:question];
        [self.tableView reloadData];
        [moc save:nil];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [results count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
    }
    
    [[cell textLabel] setText:[[results objectAtIndex:indexPath.row] question]];
    [[cell textLabel] setMinimumScaleFactor:0.1];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    NSNumber *yesVotes = [[results objectAtIndex:indexPath.row] yes];
    NSNumber *noVotes = [[results objectAtIndex:indexPath.row] no];
    NSString *subtitle = [NSString stringWithFormat:@"Yes: %@         No: %@", yesVotes, noVotes];
    [[cell detailTextLabel] setText:subtitle];
    
    return cell;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        WHAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *moc = [delegate managedObjectContext];
        [moc deleteObject:[results objectAtIndex:indexPath.row]];
        [results removeObjectAtIndex:indexPath.row];
        [moc save:nil];
        [tableView deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    WHQuestionViewController *detailViewController = [[WHQuestionViewController alloc] init];

    // Pass the selected object to the new view controller.
    [detailViewController setQuestion:[results objectAtIndex:indexPath.row]];
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
 

@end
