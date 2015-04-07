//
//  ViewController.m
//  matchismo
//
//  Created by Monik Pamecha on 25/12/14.
//  Copyright (c) 2014 etiole. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (strong,nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ModeControl;
@property (weak, nonatomic) IBOutlet UILabel *Results;
@property (strong, nonatomic) NSMutableArray *matchResults;
@end

@implementation ViewController

-(CardMatchingGame *)game {
    
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                 usingDeck:[self createDeck]];
    return _game;
}

-(NSMutableArray *)matchResults {
    
    if(!_matchResults)
        _matchResults = [[NSMutableArray alloc]init];
    return _matchResults;
}


- (IBAction)gameModeSelection:(UISegmentedControl *)sender {
    
    if(sender.selectedSegmentIndex==0)
    {
        self.game.mode = 3;
    }
    else
    {
        self.game.mode = 2;
    }
    
}

- (IBAction)touchBackButton:(UIButton *)sender {
    
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
    self.ModeControl.enabled = NO;
    
}

- (IBAction)ReDealButton:(id)sender {
    
    //reinitialize the game
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
    [self.matchResults removeAllObjects];
    self.ModeControl.enabled = YES;
    self.game.mode = (self.ModeControl.selectedSegmentIndex == 0) ? 3 : 2;
    [self updateUI];
    
}

-(Deck *)createDeck {
    
    return [[PlayingCardDeck alloc] init];
}
- (IBAction)sliderValueChanged:(UISlider *)sender {
    
    
    // find what value to show
    
    NSUInteger indexv = sender.value * ([self.matchResults count]-1);
    
    if([self.matchResults count] != 0)
        self.Results.text = [NSString stringWithFormat:@"%@", [self.matchResults objectAtIndex:indexv]];
    
}

-(void) updateUI {

    for(UIButton *cardbutton in self.cardButtons)
    {
        NSUInteger cardbuttonindex = [self.cardButtons indexOfObject:cardbutton];
        Card *card = [self.game cardAtIndex:cardbuttonindex];
        [cardbutton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardbutton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardbutton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld",(long)self.game.score];
        self.Results.text = self.game.result;
       if(self.game.result)
        [self.matchResults addObject:self.game.result];
    }
    
    
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"CardFront" : @"CardBack"];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
