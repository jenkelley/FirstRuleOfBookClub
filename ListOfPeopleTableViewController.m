//
//  ListOfPeopleTableViewController.m
//  FirstRuleOfBookClub
//
//  Created by Jen Kelley on 4/1/15.
//  Copyright (c) 2015 Jen Kelley. All rights reserved.
//

#import "ListOfPeopleTableViewController.h"
#import "Friend.h"
#import "FriendsTableViewController.h"
#import "AppDelegate.h"

@interface ListOfPeopleTableViewController ()
@property NSArray *peopleList;
@property NSMutableArray *friendList;
@end

@implementation ListOfPeopleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadPeople];

}

- (void)loadPeople
{
    FriendsTableViewController *ftv = [FriendsTableViewController new];
    ftv.moc = [AppDelegate appDelegate].managedObjectContext;

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Friend class])];
    self.peopleList = [ftv.moc executeFetchRequest:request error:nil];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.peopleList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonCell" forIndexPath:indexPath];
    Friend *person = self.peopleList[indexPath.row];
    cell.textLabel.text = person.name;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    Friend *friendObject = self.peopleList[indexPath.row];
    

    FriendsTableViewController *ftv = [FriendsTableViewController new];
    ftv.moc = [AppDelegate appDelegate].managedObjectContext;

    if ([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryNone) {
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
        friendObject.friendBool = @"yes";

        //this is a loosing battle but I don't easily admit defeat
       // [friendObject.friends setByAddingObject:friendObject];

    } else if ([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark){
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
        friendObject.friendBool = @"no";

    }

    NSLog(@"%@", friendObject.friendBool);
    [ftv.moc save:nil];
    [self.tableView reloadData];

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
