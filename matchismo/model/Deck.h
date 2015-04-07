//
//  Deck.h
//  matchismo
//
//  Created by Monik Pamecha on 25/12/14.
//  Copyright (c) 2014 etiole. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void)addCard:(Card *)card atTop:(BOOL)atTop;
-(void)addCard:(Card *)card;

-(Card *)drawRandomCard;

@end
