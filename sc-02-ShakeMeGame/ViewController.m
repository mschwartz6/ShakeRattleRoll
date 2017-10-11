//
//  ViewController.m
//  sc-02-ShakeMeGame
//
//  Created by user on 10/2/17.
//  Copyright © 2017 user. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSTimer *timer;
    int counter, score;
    //Need a mode for the game. We want to change the start button's enabled property. So when it start the button is disabled.
    int gameMode;   // 1 - Being Played ... 2 - Game Over(can press again)
    
}
-(void)startCounter;

@property (weak, nonatomic) IBOutlet UIButton *btnStart;
@property (weak, nonatomic) IBOutlet UILabel *lblTimer;
@property (weak, nonatomic) IBOutlet UILabel *lblScore;
@property (weak, nonatomic) IBOutlet UISegmentedControl *chooseTimerSegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *chooseGameSegment;


@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications ];
     [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnStartClicked:(id)sender {
    gameMode = 1;
    
    score = 0;
    [self getCounterAmt];
    self.lblScore.text = [NSString stringWithFormat:@"%i",score];
    self.lblTimer.text = [NSString stringWithFormat:@"%i", counter];
    
    //create Timer
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(startCounter) userInfo:nil repeats:YES];
    
    self.btnStart.enabled = NO;
    self.chooseTimerSegment.enabled = NO;
    self.chooseGameSegment.enabled = NO;
}
- (IBAction)timerSegmentSelected:(id)sender {
    [self getCounterAmt];
}
- (IBAction)directionButtonPressed:(id)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Directions"
                                        message:@"TO PLAY: Select between SHAKE or ROLL and the desired amount of time in seconds. SHAKE mode gives you a point when you shake the phone. ROLL mode gives you a point when you rotate the phone left or right.\n\nWhen ready select START then get shakin' 'n rollin'! How many times can you do it before the time runs out?"
                                        preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)startCounter
        {
            //decrement counter;
            counter-=1;
            self.lblTimer.text = [NSString stringWithFormat:@"%i",counter];
            if (counter ==0)
            {
                [timer invalidate];
                gameMode = 2 ;
                [self.btnStart setTitle:@"Restart" forState:UIControlStateNormal];
                self.btnStart.enabled=YES;
                self.chooseTimerSegment.enabled = YES;
                self.chooseGameSegment.enabled = YES;
            }
        }
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (event.subtype  == UIEventSubtypeMotionShake)
    {
        if(gameMode == 1 && self.chooseGameSegment.selectedSegmentIndex == 0)
        {
            score +=1;
            self.lblScore.text = [NSString stringWithFormat:@"%i",score];
        }
    }
}

-(void)orientationChanged :(NSNotification *)note
{
    if (gameMode == 1 && self.chooseGameSegment.selectedSegmentIndex == 1)
    {
        score +=1;
        self.lblScore.text = [NSString stringWithFormat:@"%i",score];
    }
}
-(void)getCounterAmt
{
    switch (self.chooseTimerSegment.selectedSegmentIndex)
    {
        case 0:
            counter = 10;
            self.lblTimer.text = @"10";
            break;
        case 1:
            counter = 20;
            self.lblTimer.text = @"20";
            break;
    }
}
@end
