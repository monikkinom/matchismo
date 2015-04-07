//
//  PlayingCard.m
//  matchismo
//
//  Created by Monik Pamecha on 25/12/14.
//  Copyright (c) 2014 etiole. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit; // because we provide setter [&&]getter

-(int)match:(NSArray *)otherCards {
    
    int score = 0;
    
    if([otherCards count] == 1)
    {
        PlayingCard *othercard = [otherCards firstObject];
        if(othercard.rank == self.rank)
        {
            score = 4;
        }
        else if([othercard.suit isEqualToString:self.suit])
        {
            score = 1;
        }
        
    }
    else if([otherCards count] == 2)
    {
        
        PlayingCard *fcard = [otherCards firstObject];
        PlayingCard *scard = [otherCards lastObject];
        int outmatch = [fcard match:@[scard]];
        int inmatch = [self match:@[fcard]];
        int exmatch = [self match:@[scard]];
        score = exmatch + inmatch + outmatch;
        
    }
    return score;
    
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

+ (NSArray *)validSuits
{
    return @[@"♥", @"♦", @"♠", @"♣"];
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank
{
    return [self rankStrings].count - 1;
}


@end
