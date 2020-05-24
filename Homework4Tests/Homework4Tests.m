//
//  Homework4Tests.m
//  Homework4Tests
//
//  Created by JaeJun Min on 08/03/2018.
//  Copyright © 2018 JaeJun Min. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Flashcard.h"
#import "FlashcardsModel.h"

@interface Homework4Tests : XCTestCase
@property (strong, nonatomic) FlashcardsModel * model;

@end

@implementation Homework4Tests

- (void)setUp {
    [super setUp];
    self.model = [[FlashcardsModel alloc] init];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
- (void)testFlashcardsModel {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSUInteger numOfFlashcard = [self.model numberOfFlashcards];
    XCTAssertNotNil(self.model);
    XCTAssertEqual(numOfFlashcard, 5);
  
    
}
- (void) testSharedModel {
    FlashcardsModel* model1 = [FlashcardsModel sharedModel];
    [model1 insertWithQuestion:@"1+1" answer:@"2" favorite:YES];
    NSInteger num1 = [model1 numberOfFlashcards];
    XCTAssertEqual(num1, 6);
    FlashcardsModel* model2 = [FlashcardsModel sharedModel];
    NSInteger num2= [model2 numberOfFlashcards];
    XCTAssertEqual(num1, num2);
    // add a flashcard to model1
    // check model2 for increase in number of flashcards
}
-(void) testNumOfFlashcards{
    //test number of flashcards
    NSUInteger num1 = [self.model numberOfFlashcards];
    XCTAssertEqual(num1, 5);
}
-(void) testRandomFlashcard{
 [self.model randomFlashcard];
 NSUInteger num = self.model.currentIndex;
    XCTAssertLessThan(num, self.model.numberOfFlashcards);
    
}

-(void) testFlashcardAtIndex{
   
  // add new index at end of flashcard with question "test"
    [self.model insertWithQuestion:@"test" answer:@"test" favorite:YES];
    NSUInteger num1 = [self.model numberOfFlashcards];
    XCTAssertEqual(num1, 6);
   
//get flashcard at end of array by using a specific index number (5)
//get another falshcard by using numberofFlashcards function - 1 and compare these two objects.

    Flashcard* model1 = [self.model flashcardAtIndex:5];
    Flashcard* model2 = [self.model flashcardAtIndex:self.model.numberOfFlashcards-1];
  
    XCTAssertEqualObjects(model1, model2);
    
  
  
}
-(void) testInsertFlashcard{
    
    FlashcardsModel* model1 = [[FlashcardsModel alloc] init];
    NSUInteger num1 = [model1 numberOfFlashcards];
    XCTAssertEqual(num1, 5);
    //insert flashcard at the end of array
    [model1 insertWithQuestion:@"1*1" answer:@"1" favorite:YES];
    NSUInteger num2 = [model1 numberOfFlashcards];
    XCTAssertEqual(num2, 6);
    
}
- (void) testInsertFlashcardAtIndex{
    FlashcardsModel* model1 = [[FlashcardsModel alloc] init];
    NSUInteger num1 = [model1 numberOfFlashcards];
    XCTAssertEqual(num1, 5);
    // Should not insert a flashcard if the index is greater than the num
     [model1 insertWithQuestion:@"Add" answer:@"added" favorite:YES atIndex:6];
    XCTAssertEqual(num1, 5);
    //add flashcard at specific index
    [model1 insertWithQuestion:@"Add" answer:@"added" favorite:YES atIndex:3];
    NSUInteger num2 = [model1 numberOfFlashcards];
    XCTAssertEqual(num2, 6);
    
}
- (void) testRemoveFlashcard{
    NSUInteger num = [self.model numberOfFlashcards];
    XCTAssertEqual(num, 5);
    [self.model removeFlashcard];
    num = [self.model numberOfFlashcards];
    XCTAssertEqual(num, 4);
}
- (void) testRemoveFlashcardAtIndex{
    //check for number of flashcard before remove
    NSUInteger num = [self.model numberOfFlashcards];
    XCTAssertEqual(num, 5);
    //shoud not remove a flashcard if the index if greater than the num of flashcards
    [self.model removeFlashcardAtIndex:6];
    num = [self.model numberOfFlashcards];
    XCTAssertEqual(num, 5);
    //remove the flashcard at specific index
    [self.model removeFlashcardAtIndex:2];
    num = [self.model numberOfFlashcards];
    XCTAssertEqual(num, 4);
    
}
- (void) testToggleFav{
    //if flachard is not favorite card (false)then chagne to not favrite card(true)
    Flashcard * model1 = [self.model flashcardAtIndex:1];
    XCTAssertFalse(model1.isFavorite);
    [self.model toggleFavorite];
    XCTAssertTrue(model1.isFavorite);
    //if flashcard is favorite card (ture) then change to not favorite card(false)
    Flashcard *model2 = [self.model flashcardAtIndex:0];
    XCTAssertTrue(model2.isFavorite);
    [self.model toggleFavorite];
    XCTAssertFalse(model2.isFavorite);
    
}
- (void) testFavFlashCards{
    NSArray* favCards = [self.model favoriteFlashcards];
    NSUInteger countFav=0;
    Flashcard * favCard;
    for(int i =0; i < [self.model numberOfFlashcards]; i++ ){
        favCard = [self.model flashcardAtIndex:i];
        if(favCard.isFavorite){
            countFav++;
        }
    }
    XCTAssertEqual(countFav, [favCards count]);
}
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
