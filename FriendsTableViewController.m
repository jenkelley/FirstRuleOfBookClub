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
@property NSArray *friendArray;
@end

@implementation FriendsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.moc = [AppDelegate appDelegate].managedObjectContext;

    self.friendArray = [NSArray new];
        [Friend getAllMyFriends:^(NSArray *peopleArray) {
        self.friendArray = peopleArray;
        NSLog(@"you have friends");
            [self loadFriends];
            [self.tableView reloadData];

        }];


}

//I'm doing this here because if a friend is deleted, their comments and books will still be saved.
-(void)loadFriends{

    for (NSString *personName in self.friendArray) {
        Friend *friend = [NSEntityDescription insertNewObjectForEntityForName:@"Friend" inManagedObjectContext:self.moc];
        [friend setValue:personName forKey:@"name"];
        [friend setValue:@"no" forKey:@"friend"];
            [self.moc save:nil];
    }

}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.friendArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.friendArray[indexPath.row];
    
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
