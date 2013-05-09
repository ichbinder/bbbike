//
//  ViewController.h
//  BBBike
//
//  Created by Icke Horst on 25.04.13.
//  Copyright (c) 2013 Icke Horst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "GeoGoogleParser.h"
#import "GeoObjekt.h"
#import "StyledPullableView.h"
#import "XBPageDragView.h"
#import <MapKit/MapKit.h>


@interface ViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITextField *textFildFrom;
@property (strong, nonatomic) IBOutlet UITextField *textFildTo;
@property (weak,nonatomic)    GeoObjekt *geoObjektFrom;
@property (weak,nonatomic)    GeoObjekt *geoObjektTo;
@property (retain, nonatomic) NSMutableArray *geoObjektArray;
@property (nonatomic)         NSInteger geoGoogleParserObjektCount;
@property (weak, nonatomic) IBOutlet UITableView *geoDataTableView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *frontView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet XBPageDragView *pageDragView;


- (BOOL)textFieldShouldReturn:(UITextField *)textField;
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end