//
//  FlashcardsModel.m
//  Homework4
//
//  Created by JaeJun Min on 13/03/2018.
//  Copyright © 2018 JaeJun Min. All rights reserved.
//

#import "FlashcardsModel.h"



// class extension
@interface FlashcardsModel ()
// private properties
@property (strong, nonatomic) NSMutableArray* flashcards;

// filepath
@property (strong, nonatomic) NSString* filepath;
@end
@implementation FlashcardsModel

+ (instancetype) sharedModel {
    // static ivar
    static FlashcardsModel *_sharedModel = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // code to be executed once - thread safe version
        _sharedModel = [[self alloc] init];
    });
    return _sharedModel;
}


// overriding NSObject's init method
- (instancetype)init
{
    self = [super init];
    if (self) {
        // alloc & init any properties
        // ivar _propertyName
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = paths[0];
        NSLog(@"docDir = %@", documentsDirectory);
        self.filepath = [documentsDirectory stringByAppendingPathComponent:@"flashcards.plist"];
        NSLog(@"filepath = %@", self.filepath);
        
        NSMutableArray *data = [NSMutableArray arrayWithContentsOfFile: self.filepath];
        _currentIndex=0;
       if(!data){
            self.flashcards = [[NSMutableArray alloc] init];
            Flashcard* flashcard1 = [[Flashcard alloc] initWithQuestion:@"Can an array in object-c holds elements of different types?" answer:@"YES" isFavorite:YES];
            Flashcard* flashcard2 = [[Flashcard alloc] initWithQuestion:@"With sigleton, there can be multiple instances of class" answer:@"No, only one instance can be created" isFavorite:NO];
            Flashcard* flashcard3 = [[Flashcard alloc] initWithQuestion:@"NSArray can add or remove objects from array" answer:@"No" isFavorite:YES];
            Flashcard* flashcard4 = [[Flashcard alloc] initWithQuestion:@"NSDictionary can modify values and keys" answer:@"No, only values can be modified" isFavorite:YES];
            Flashcard* flashcard5 = [[Flashcard alloc] initWithQuestion:@"What type of colltions allow to add and remove objects?" answer:@"Mutable collections" isFavorite:NO];
            self.flashcards = [NSMutableArray arrayWithObjects:flashcard1,flashcard2,flashcard3,flashcard4,flashcard5, nil];
           
        }
      else {
            self.flashcards = [[NSMutableArray alloc] init];
            for (NSDictionary* dict in data) {
                
                // NSDictionary object to Student object
                Flashcard* flashcard = [[Flashcard alloc] initWithQuestion:dict[@"questionKey"] answer:dict[@"ansKey"] isFavorite:dict[@"isFav"]];
                
                [self.flashcards addObject: flashcard];
            }
        }

    }
    [self save];
    return self;
}
//- (NSUInteger) currentIndex: (Flashcard*)flashcard{
//  return _currentIndex = [self.flashcards indexOfObject: flashcard];
//}
- (NSUInteger) numberOfFlashcards{
      return [self.flashcards count];
}

- (Flashcard *) randomFlashcard{
    NSUInteger x = [self numberOfFlashcards];
   _currentIndex = arc4random_uniform((int32_t) x);
    return self.flashcards[_currentIndex];
}
- (Flashcard *) flashcardAtIndex: (NSUInteger) index{
    _currentIndex=index;
     [self save];
   return self.flashcards[index];
}
- (Flashcard *) nextFlashcard{
    if(self.currentIndex+1 >= self.numberOfFlashcards ){
        _currentIndex= 0;
        return self.flashcards[_currentIndex];}
    else{
        _currentIndex++;
        return self.flashcards[self.currentIndex];
    }
    
}
- (Flashcard *) prevFlashcard{
    if(self.currentIndex == 0 ){
        _currentIndex = self.numberOfFlashcards-1;
        return self.flashcards[_currentIndex];}
    else{
        _currentIndex--;
        return self.flashcards[self.currentIndex];
    }
}
// Inserting a flashcard
- (void) insertWithQuestion: (NSString *) question
                     answer: (NSString *) ans
                   favorite: (BOOL) fav{
    Flashcard* newFlashcard = [[Flashcard alloc]
                               initWithQuestion:question answer:ans isFavorite:fav];
    
    [self.flashcards addObject: newFlashcard];
    [self save];
    
}
- (void) insertWithQuestion: (NSString *) question
                     answer: (NSString *) ans
                   favorite: (BOOL) fav
                    atIndex: (NSUInteger) index{
    Flashcard* newFlashcard = [[Flashcard alloc]
                               initWithQuestion:question answer:ans isFavorite:fav];
    if(index <= self.numberOfFlashcards){
            [self.flashcards insertObject:newFlashcard atIndex:index];
        }
    [self save];
}
- (void) removeFlashcard{
    if ([self numberOfFlashcards] > 0) {
        [self.flashcards removeLastObject];
    }
    [self save];
}
- (void) removeFlashcardAtIndex: (NSUInteger) index{
    
    NSUInteger num = [self numberOfFlashcards];
    
    
    if (num > 0 && index < num) {
        [self.flashcards removeObjectAtIndex: index];
    } else {
        NSLog(@"There are no students or you have a bad index");
    }
    [self save];
}

- (void) toggleFavorite{
    Flashcard * fc = [self flashcardAtIndex:self.currentIndex];
    if(fc.isFavorite ==YES){
        fc.isFavorite=NO;

    }else{
        fc.isFavorite=YES;
    
    }
    [self save];
  
}
-(NSArray *) favoriteFlashcards{

    NSMutableArray* favCard =[[NSMutableArray alloc] init];
    for(Flashcard* fc in self.flashcards){
        NSLog(@"count");
        if(fc.isFavorite == YES){
            [favCard addObject:fc];
        }
    }
    return favCard;
}

- (void) save {
    NSMutableArray *flashcards = [[NSMutableArray alloc] init];
    for (Flashcard* fc in self.flashcards) {
        NSDictionary *flashcardDict = [fc convertToDictionary];
        [flashcards addObject:flashcardDict];
    }
    [flashcards writeToFile: self.filepath atomically:YES];
}



@end
