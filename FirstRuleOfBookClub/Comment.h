//
//  Comment.h
//  FirstRuleOfBookClub
//
//  Created by Jen Kelley on 4/1/15.
//  Copyright (c) 2015 Jen Kelley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Book;

@interface Comment : NSManagedObject

@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSSet *book;
@end

@interface Comment (CoreDataGeneratedAccessors)

- (void)addBookObject:(Book *)value;
- (void)removeBookObject:(Book *)value;
- (void)addBook:(NSSet *)values;
- (void)removeBook:(NSSet *)values;

@end
