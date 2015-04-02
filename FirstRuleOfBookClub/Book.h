//
//  Book.h
//  FirstRuleOfBookClub
//
//  Created by Jen Kelley on 4/1/15.
//  Copyright (c) 2015 Jen Kelley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Book : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSSet *friend;
@property (nonatomic, retain) NSManagedObject *comment;
@end

@interface Book (CoreDataGeneratedAccessors)

- (void)addFriendObject:(NSManagedObject *)value;
- (void)removeFriendObject:(NSManagedObject *)value;
- (void)addFriend:(NSSet *)values;
- (void)removeFriend:(NSSet *)values;

@end
