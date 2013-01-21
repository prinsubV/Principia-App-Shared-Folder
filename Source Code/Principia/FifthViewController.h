//
//  FourthViewController.h
//  Principia
//
//  Created by Dale Matheny on 10/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MediaPlayer/MediaPlayer.h"

@interface FifthViewController : UIViewController
{

    UIButton *aButton;
    MPMoviePlayerController *player;
    bool isPlaying;
}

@property(nonatomic, retain) IBOutlet UIButton *aButton;
@property(strong, retain) MPMoviePlayerController *player;
-(IBAction)PlayStream:(id)sender;

@end
