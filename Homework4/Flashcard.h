//
//  Flashcard.h
//  Homework4
//
//  Created by JaeJun Min on 13/03/2018.
//  Copyright © 2018 JaeJun Min. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Flashcard : NSObject

// public properties
@property (strong, nonatomic, readonly) NSString* question;
@property (strong, nonatomic, readonly) NSString* answer;
@property (nonatomic) BOOL  isFavorite;

// Initializing the flashcard
- (instancetype) initWithQuestion: (NSString *) question
                           answer: (NSString *) ans;
- (instancetype) initWithQuestion: (NSString *) question
                           answer: (NSString *) ans
                       isFavorite: (BOOL) isFav;
- (NSString*) fullFlashcard;
- (NSDictionary *) convertToDictionary;
@end
