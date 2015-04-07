//
//  CardMatchingGame.m
//  matchismo
//
//  Created by Monik Pamecha on 28/12/14.
//  Copyright (c) 2014 etiole. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic,readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;

@end


@implementation CardMatchingGame

static int const MISMATCH_PENALTY = 2;
static int const MATCH_BONUS = 4;
static int const COST_TO_CHOOSE = 1;

-(NSMutableArray *)cards {
    
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
    
}


-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if(self)
    {
        for(int i =0; i<count; i++)
        {
            Card *randcard = [deck drawRandomCard];
            if(randcard)
            {
            [self.cards addObject:randcard];
            }
            else
            {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index {
    
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

-(NSInteger)mode {
    
    return _mode ? _mode : 3;
}


-(void)chooseCardAtIndex:(NSUInteger)index {
    
    Card *card = [self cardAtIndex:index];
    self.result = [NSString stringWithFormat:@"%@ chosen",card.contents];
        if(!card.isMatched)
      {
            if(card.isChosen)
        {
            card.chosen = NO;
            self.result = [NSString stringWithFormat:@"%@ turned back",card.contents];
        }
        else{
           
            NSMutableArray *opencards = [[NSMutableArray alloc] init];
            
            for(Card *othercard in self.cards)
            {
                
                if(othercard.isChosen && !othercard.isMatched)
                {
                    
                    [opencards addObject:othercard];
                  
                }
            }
            
            
            int matchscore = [card match:opencards];
            
            
            if( self.mode == 3)
            {
                
                if([opencards count]==2)
                {
                    
                    
                    Card *uno = [opencards firstObject];
                    Card *tre = [opencards lastObject];
                    
                    if(matchscore)
                    {
                        self.score += matchscore*MATCH_BONUS;
                        card.matched = YES;
                        uno.matched = YES;
                        tre.matched = YES;
                        self.result = [NSString stringWithFormat:@"%@ %@ and %@ matched for %d",card.contents,uno.contents,tre.contents,matchscore*MATCH_BONUS];
                    }
                    else
                    {
                        self.score -= MISMATCH_PENALTY;
                        uno.chosen = NO;
                        tre.chosen = NO;
                        self.result = [NSString stringWithFormat:@"%@ %@ and %@ not matched. Penalty %d",card.contents,uno.contents,tre.contents,MISMATCH_PENALTY];
                        
                        
                    }
                    
                }
                else
                {
                    if([opencards count] == 1)
                    {
                        Card *tempcard = [opencards firstObject];
                        self.result =[NSString stringWithFormat:@"%@ and %@",card.contents,tempcard.contents];
                    }
                }
                
            }
            else if ( [opencards count] == 1)
            {
                Card *othercard = [opencards firstObject];
                
                if(matchscore)
                {
                    self.score += matchscore*MATCH_BONUS;
                    othercard.matched = YES;
                    card.matched = YES;
                    self.result = [NSString stringWithFormat:@"%@ and %@ matched for %d",card.contents,othercard.contents,matchscore*MATCH_BONUS];
                }
                else
                {
                    self.score -= MISMATCH_PENALTY;
                    othercard.chosen=NO;
                    self.result = [NSString stringWithFormat:@"%@ and %@ no match. Penalty of %d",card.contents,othercard.contents,MISMATCH_PENALTY];
                }
                
            }
            
            
            card.chosen = YES;
            
            self.score -= COST_TO_CHOOSE;
        }
      }
    
        
    
    
    
    
    
    
    
    
    
    
    
    
}


@end
