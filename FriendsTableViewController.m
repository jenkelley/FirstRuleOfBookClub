//
//  FriendsTableViewController.m
//  FirstRuleOfBookClub
//
//  Created by Jen Kelley on 4/1/15.
//  Copyright (c) 2015 Jen Kelley. All rights reserved.
//

#import "FriendsTableViewController.h"
#import "Friend.h"
#import "AppDelegate.h"
#import "ListOfPeopleTableViewController.h"

@interface FriendsTableViewController ()
@property Friend *person;
@property NSArray *PersonArray;
@property NSArray *friendsArray;
@end

@implementation FriendsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.moc = [AppDelegate appDelegate].managedObjectContext;

    self.PersonArray = [NSArray new];
        [Friend getAllMyFriends:^(NSArray *peopleArray) {
        self.PersonArray = peopleArray;
        NSLog(@"you have friends");
  //          [self loadPeople];
            [self.tableView reloadData];
        }];
}

-(void)viewWillAppear:(BOOL)animated{
    [self loadFriends];

}

//I'm doing this here because if a friend is deleted, their comments and books will still be saved.
//REFACTOR:move this to listofpeopletableviewcontroller
-(void)loadPeople{

    for (NSString *personName in self.PersonArray) {
        Friend *friend = [NSEntityDescription insertNewObjectForEntityForName:@"Friend" inManagedObjectContext:self.moc];
        [friend setValue:personName forKey:@"name"];
        [friend setValue:@NO forKey:@"friendBool"];
        [self.moc save:nil];
    }
}

- (void)loadFriends
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Friend class])];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"friendBool == YES"];
    request.predicate = predicate;
    self.friendsArray = [self.moc executeFetchRequest:request error:nil];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.friendsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    Friend *friend = self.friendsArray[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendCell" forIndexPath:indexPath];
    
    cell.textLabel.text = friend.name;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
