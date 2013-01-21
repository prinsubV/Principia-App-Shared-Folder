//
//  FirstViewController.m
//  Principia
//  Chapel/PIR
//
//  Created by Dale Matheny on 10/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FifthViewController.h"

@interface FifthViewController ()
@end

@implementation FifthViewController
@synthesize aButton, player;

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    
	[self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
    
	[self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Prin", @"Prin");
        self.tabBarItem.image = [UIImage imageNamed:@"bullhorn"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

-(IBAction)PlayStream:(id)sender
{
    if(player != nil)
    {
        
        if(isPlaying)
        {
            [player pause];
            UIImage *pause1 = [[UIImage alloc] initWithContentsOfFile:@"play.jpg"];
            [aButton setImage:pause1 forState:UIControlStateNormal];
        }
        
        else {
            UIImage *pause2 = [[UIImage alloc] initWithContentsOfFile:@"pause.jpg"];
            [aButton setImage:pause2 forState:UIControlStateNormal];
            [player play];
        }
        isPlaying = !isPlaying;
    }
    
    if(player == nil){
        player = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:@"http://prinedu.ic.llnwd.net/stream/prinedu_stream.pls"]];
        player.movieSourceType = MPMovieSourceTypeStreaming;
        player.view.hidden = YES;
        [self.view addSubview:player.view];
        [player play];
        isPlaying = true;
    }
}

@end
