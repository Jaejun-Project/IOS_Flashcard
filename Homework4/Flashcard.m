//
//  Flashcard.m
//  Homework4
//
//  Created by JaeJun Min on 13/03/2018.
//  Copyright © 2018 JaeJun Min. All rights reserved.
//

#import "Flashcard.h"

@implementation Flashcard

- (instancetype) initWithQuestion:(NSString *)question answer:(NSString *)ans{
    
    return [self initWithQuestion:question answer:ans];
}
-(instancetype) initWithQuestion:(NSString *)question
                          answer:(NSString *)ans
                      isFavorite:(BOOL)isFav{
    self = [super init];
    if (self) {
        _question = question;
        _answer = ans;
        _isFavorite= isFav;
    }
    return self;
}

- (NSDictionary *) convertToDictionary {
  
    NSDictionary *flashcardDict = [NSDictionary dictionaryWithObjectsAndKeys:self.question, @"questionKey",self.answer, @"ansKey",[NSNumber numberWithBool:self.isFavorite], @"isFav",nil];
    
    
    
    return flashcardDict;

}

- (NSString *) fullFlashcard {
    NSString* fullString = [NSString stringWithFormat: @"Question: %@ \n Answer: %@  \n Favorite: %d",
                            self.question, self.answer, self.isFavorite];
    return fullString;
}

@end
