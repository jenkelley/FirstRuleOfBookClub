//
//  Friend.m
//  FirstRuleOfBookClub
//
//  Created by Jen Kelley on 4/2/15.
//  Copyright (c) 2015 Jen Kelley. All rights reserved.
//

#import "Friend.h"
#import "Book.h"


@implementation Friend

@dynamic name;
@dynamic picture;
@dynamic friendBool;
@dynamic book;


+(void)getAllMyFriends:(void (^)(NSArray *peopleArray))completion{


    NSURL *url = [NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/18/friends.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSArray *personArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
        NSLog(@"data received, %lu", (unsigned long)personArray.count);
        completion(personArray);
    }];
}


@end
