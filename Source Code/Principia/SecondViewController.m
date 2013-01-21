//
//  SecondViewController.m
//  Principia
//
//  Created by Dale Matheny on 10/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"
#import "FifthViewController.h"
#import "Contacts.h"
#import "Course1.h"
#import "AppDelegate.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

@synthesize Image, Scroller, eventlist;

- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:kFilename];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Events", @"Events");
        self.tabBarItem.image = [UIImage imageNamed:@"events"];
    }
    return self;
}

-(NSDate *)dateParser:(NSMutableString *) rawstr
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [dateFormat setDateFormat:@"dd/MM/yy HH:mm:ss"];
    NSString *data = rawstr;
    NSDate *date = [dateFormat dateFromString:data];
    
    return date;
}

-(void)tapButton {
    Course1 *course1 = [[Course1 alloc] initWithNibName:@"Course1" bundle:nil];
    [self.navigationController pushViewController:course1 animated:NO];
}

-(void)buttonCreate
{
    int xrel = 26;
    NSDate *start;
    NSDate *finish;
    
    for(NSDictionary *item in eventlist)
    {
        UIColor *eventcolor;
        NSString *name;
        int eventtype =[[item objectForKey:@"eventtype"] intValue];
        if(eventtype == 1)
        {
            eventcolor = [UIColor greenColor];
            name = @"Class";
        }
        if(eventtype == 2)
        {
            eventcolor = [UIColor grayColor];
            name = @"Meal";
        }
        
        
        
        start = [item objectForKey:@"starttime"];
        finish = [item objectForKey:@"endtime"];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        [calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:start];
        NSInteger hour = [components hour];
        NSTimeInterval diff = [finish timeIntervalSinceDate:start]/60;
        NSInteger minutes = [components minute];
        float fmin = (float)minutes;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:name forState:UIControlStateNormal];
        float ycord = (37.0*hour)+((fmin/60.0)*37.0);
        float yheight = diff*0.6;
        button.frame = CGRectMake(26.0, ycord, 80.0, yheight); //37*hour, height of event = min*0.6
        button.backgroundColor = eventcolor;
        [button addTarget:self action:@selector(tapButton) forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
        
        [Image addSubview:button];
        
    }
    
    
    
    
}

-(void)DataRead
{
    
    NSMutableDictionary *row;
    NSString *dataquery = @"SELECT date, time(starttime) AS Start, time(endtime) AS Ending, itemdiscrpt, Location,eventtype FROM events WHERE date = \"11/11/12\";";
    sqlite3_stmt *statement;
    
    
    if (sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK) {
		sqlite3_close(database);
		NSAssert(0, @"Failed to open database");
	}
    
    if(sqlite3_prepare_v2(database, [dataquery UTF8String],-1,&statement,nil)==SQLITE_OK)
    {
        
        while(sqlite3_step(statement) == SQLITE_ROW)
        {
            
            NSArray *keys = [[NSArray alloc] initWithObjects:@"starttime",@"endtime",@"itemdiscrpt",@"Location",@"eventtype", nil];
            NSMutableArray *values = [[NSMutableArray alloc] initWithCapacity:6];
            NSMutableString *fstdate;
            NSMutableString * ScdDate;
            for (int index = 0; index < 6; index++) {
                NSMutableString *raw = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement,index)];
                
                if([raw rangeOfString:@"/"].location != NSNotFound) {
                    fstdate = [[NSMutableString alloc] initWithString:raw];
                    ScdDate = [[NSMutableString alloc] initWithString:raw];
                    continue;
                }
                if([raw rangeOfString:@":"].location != NSNotFound && index == 1)
                {
                    [fstdate appendString:@" "];
                    [fstdate appendString:raw];
                    [values addObject:[self dateParser:fstdate]];
                    continue;
                }
                else if([raw rangeOfString:@":"].location != NSNotFound && index == 2)
                {
                    [ScdDate appendString:@" "];
                    [ScdDate appendString:raw];
                    [values addObject:[self dateParser:ScdDate]];
                    continue;
                }
                [values addObject:raw];
                
            }
            
            row = [[NSMutableDictionary alloc]initWithObjects:values forKeys:keys];
            [eventlist addObject:row];
            
            
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.Scroller.contentSize = self.Image.image.size;
    self.Image.frame = CGRectMake(0, 0, self.Image.image.size.width, self.Image.image.size.height);
    self.Image.userInteractionEnabled = YES;
    
//    AppDelegate* blah = (AppDelegate*)[[UIApplication sharedApplication]delegate];
//    blah.navController.navigationBar.topItem.title = @"Events";
    
    if(eventlist == nil)
    {
        eventlist = [NSMutableArray new];
    }
    
    [self DataRead];
    [self buttonCreate];    
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

@end
