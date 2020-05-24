//
//  FlashcardsModel.h
//  Homework4
//
//  Created by JaeJun Min on 13/03/2018.
//  Copyright © 2018 JaeJun Min. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Flashcard.h"

@interface FlashcardsModel : NSObject


@property (readonly, nonatomic) NSUInteger currentIndex;

// Creating the model
+ (instancetype) sharedModel;
// Accessing number of flashcards in model
- (NSUInteger) numberOfFlashcards;
//- (NSUInteger) currentIndex: (Flashcard *) flashcard;
// Accessing a flashcard – sets currentIndex appropriately
- (Flashcard *) flashcardAtIndex: (NSUInteger) index;
- (Flashcard *) randomFlashcard;
- (Flashcard *) nextFlashcard;
- (Flashcard *) prevFlashcard;
// Inserting a flashcard
- (void) insertWithQuestion: (NSString *) question
                     answer: (NSString *) ans
                   favorite: (BOOL) fav;
- (void) insertWithQuestion: (NSString *) question
                     answer: (NSString *) ans
                   favorite: (BOOL) fav
                    atIndex: (NSUInteger) index;
// Removing a flashcard
- (void) removeFlashcard;
- (void) removeFlashcardAtIndex: (NSUInteger) index;
// Favorite/unfavorite the current flashcard
- (void) toggleFavorite;
// Getting the favorite flashcards
- (NSArray *) favoriteFlashcards;
@end
