//
//  FirstViewController.h
//  Principia
//
//  Created by Dale Matheny on 10/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#define METERS_PER_MILE 1609.344

@interface FirstViewController : UIViewController
{
    UIColor *defaultTintColor;
    MKMapView *mapView;    
}
@property (nonatomic, retain) IBOutlet MKMapView *mapView;

@end
