//
//  Card.m
//  matchismo
//
//  Created by Monik Pamecha on 25/12/14.
//  Copyright (c) 2014 etiole. All rights reserved.
//

#import "Card.h"

@implementation Card

-(int) match:(NSArray *)otherCards
{
    int score = 0 ;
    
    for(Card *card in otherCards)
    {
        if ([card.contents isEqualToString:self.contents])
            score = 1;
    }
    
    return score;
}

@end
