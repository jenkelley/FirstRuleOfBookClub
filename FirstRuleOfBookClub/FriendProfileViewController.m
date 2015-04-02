//
//  FriendProfileViewController.m
//  FirstRuleOfBookClub
//
//  Created by Jen Kelley on 4/1/15.
//  Copyright (c) 2015 Jen Kelley. All rights reserved.
//

#import "FriendProfileViewController.h"
#import "Book.h"
#import "FriendsTableViewController.h"
#import "AppDelegate.h"

@interface FriendProfileViewController () <UITableViewDataSource, UITableViewDelegate>
@property NSArray *bookArray;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FriendProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];

}

- (void)loadFriends
{
    FriendsTableViewController *ftv = [FriendsTableViewController new];
    ftv.moc = [AppDelegate appDelegate].managedObjectContext;

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Book class])];
   // NSPredicate *predicate = [NSPredicate predicateWithFormat:@"friendBool == YES"];
 //   request.predicate = predicate;
    self.bookArray = [ftv.moc executeFetchRequest:request error:nil];
    [self.tableView reloadData];
}

- (IBAction)onSuggestABookButtonTapped:(id)sender {

    FriendsTableViewController *ftv = [FriendsTableViewController new];
    ftv.moc = [AppDelegate appDelegate].managedObjectContext;

    UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"It's ok to talk about Book Club here" message:nil preferredStyle:UIAlertControllerStyleAlert];

    [alertcontroller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        nil;
    }];

    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"READ THIS NOW!"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   UITextField *textField = alertcontroller.textFields.firstObject;
                                  Book *book  = [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:ftv.moc];
                                   book.title = textField.text;

                                   NSLog(@"book title is %@", book.title);
                                   UITextField *textFieldTwo = alertcontroller.textFields.lastObject;
                                   book.author = textFieldTwo.text;
                                   [ftv.moc save:nil];
                                   [self loadFriends];
                               }];

    [alertcontroller addAction:okAction];

    [self presentViewController:alertcontroller animated:YES completion:^{
        nil;
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.bookArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    Book *book = self.bookArray[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookCell" forIndexPath:indexPath];
    cell.textLabel.text = book.title;

    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
