//
//  Friend.h
//  FirstRuleOfBookClub
//
//  Created by Jen Kelley on 4/2/15.
//  Copyright (c) 2015 Jen Kelley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Book;

@interface Friend : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * picture;
@property (nonatomic, retain) NSNumber * friendBool;
@property (nonatomic, retain) NSSet *book;
@end

@interface Friend (CoreDataGeneratedAccessors)

- (void)addBookObject:(Book *)value;
- (void)removeBookObject:(Book *)value;
- (void)addBook:(NSSet *)values;
- (void)removeBook:(NSSet *)values;

+(void)getAllMyFriends:(void (^)(NSArray *peopleArray))completion;

@end
