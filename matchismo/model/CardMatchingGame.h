//
//  CardMatchingGame.h
//  matchismo
//
//  Created by Monik Pamecha on 28/12/14.
//  Copyright (c) 2014 etiole. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

//designated initializer
-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

-(void)chooseCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic) NSInteger mode;
@property (nonatomic,readonly) NSInteger score;
@property (nonatomic) NSString *result;

@end
