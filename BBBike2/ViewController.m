//
//  ViewController.m
//  BBBike
//
//  Created by Icke Horst on 25.04.13.
//  Copyright (c) 2013 Icke Horst. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end


@implementation ViewController

@synthesize textFildFrom = _textFildFrom;
@synthesize textFildTo = _textFildTo;
@synthesize geoObjektFrom = _geoObjektFrom;
@synthesize geoObjektTo = _geoObjektTo;
@synthesize geoObjektArray = _geoObjektArray;
@synthesize geoGoogleParserObjektCount = _gepGoogleParserObjektCount;
@synthesize geoDataTableView = _geoDataTableView;
@synthesize mapView = _mapView;
@synthesize frontView = _frontView;
@synthesize backView = _backView;
@synthesize pageDragView = _pageDragView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    XBSnappingPoint *point = [[XBSnappingPoint alloc] initWithPosition:CGPointMake(self.pageDragView.viewToCurl.frame.size.width*0.3, self.pageDragView.viewToCurl.frame.size.height*0.4) angle:6*M_PI/7.3 radius:80 weight:0.2];
    [self.pageDragView.pageCurlView addSnappingPoint:point];
    
    StyledPullableView *pullDownView = [[StyledPullableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    pullDownView.openedCenter = CGPointMake(160 , -120);
    pullDownView.closedCenter = CGPointMake(160 , -200);
    pullDownView.center = pullDownView.openedCenter;
    
    [self.mapView addSubview:pullDownView];
    
    self.textFildFrom = [[UITextField alloc] initWithFrame:CGRectMake(40, pullDownView.frame.size.width + 40, 240, 25)];
    self.textFildFrom.delegate = self;
    self.textFildFrom.textColor = [UIColor grayColor];
    [self.textFildFrom setFont:[UIFont systemFontOfSize:12.0f]];
    self.textFildFrom.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.textFildFrom.text = @"From";
    self.textFildFrom.borderStyle = UITextBorderStyleRoundedRect;//To change borders to rounded
    self.textFildFrom.layer.borderWidth = 0.0f; //To hide the square corners
    self.textFildFrom.layer.borderColor = [[UIColor grayColor] CGColor];
    self.textFildFrom.returnKeyType = UIReturnKeySearch;
    
    [pullDownView addSubview:self.textFildFrom];
    
    self.textFildTo = [[UITextField alloc] initWithFrame:CGRectMake(40, pullDownView.frame.size.width + 80, 240, 25)];
    self.textFildTo.delegate = self;
    self.textFildTo.textColor = [UIColor grayColor];
    [self.textFildTo setFont:[UIFont systemFontOfSize:12.0f]];
    self.textFildTo.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.textFildTo.text = @"To";
    self.textFildTo.borderStyle = UITextBorderStyleRoundedRect;//To change borders to rounded
    self.textFildTo.layer.borderWidth = 0.0f; //To hide the square corners
    self.textFildTo.layer.borderColor = [[UIColor grayColor] CGColor];
    self.textFildTo.returnKeyType = UIReturnKeySearch;
    
    [pullDownView addSubview:self.textFildTo];
    
    [self.geoDataTableView setHidden:YES];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    if (textField == self.textFildFrom) {
        if (textField.returnKeyType == UIReturnKeySearch) {
            if (self.textFildFrom.text.length == 0) {
                self.textFildFrom.text = @"Pleas write ...";
                self.geoObjektFrom = nil;
                self.textFildFrom.textColor = [UIColor grayColor];
            } else {
                GeoGoogleParser *parserFrom = [[GeoGoogleParser alloc] initWithAddress:self.textFildFrom.text];
                NSMutableArray *geoObjektArryFrom = parserFrom.geoObjektArray;
                self.geoGoogleParserObjektCount = geoObjektArryFrom.count;
                self.geoObjektArray = geoObjektArryFrom;
                [self.geoDataTableView setHidden:NO];
                [self.geoDataTableView reloadData];
            }
        }
    }
    
    if (textField == self.textFildTo) {
        if (textField.returnKeyType == UIReturnKeySearch) {
            if (self.textFildTo.text.length == 0) {
                self.textFildTo.text = @"Pleas write ...";
                self.geoObjektTo = nil;
                self.textFildTo.textColor = [UIColor grayColor];
            } else {
                GeoGoogleParser *parserTo = [[GeoGoogleParser alloc] initWithAddress:self.textFildTo.text];
                NSMutableArray *geoObjektArryTo = parserTo.geoObjektArray;
                self.geoGoogleParserObjektCount = geoObjektArryTo.count;
                self.geoObjektArray = geoObjektArryTo;
                [self.geoDataTableView setHidden:NO];
                [self.geoDataTableView reloadData];
            }
        }
    }
    
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.textFildFrom) {
        self.textFildFrom.text = @"";
        self.textFildFrom.textColor = [UIColor blackColor];
        if (self.geoObjektFrom != nil)
            self.textFildFrom.text = [self.geoObjektFrom geoName];
        [self.textFildTo setEnabled:NO];
    }else if (textField == self.textFildTo) {
        self.textFildTo.text = @"";
        self.textFildTo.textColor = [UIColor blackColor];
        if (self.geoObjektTo != nil)
            self.textFildTo.text = [self.geoObjektTo geoName];
        [self.textFildFrom setEnabled:NO];
    }
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.geoGoogleParserObjektCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    GeoObjekt *tmpGeoObjekt = [self.geoObjektArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [[[tmpGeoObjekt geoName] componentsSeparatedByString:@","] objectAtIndex:0];
    cell.detailTextLabel.text = [tmpGeoObjekt geoName];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.textFildFrom.isEnabled) {
        self.textFildFrom.text = [[self.geoObjektArray objectAtIndex:indexPath.row] geoName];
        self.geoObjektFrom = [self.geoObjektArray objectAtIndex:indexPath.row];
        [self.geoDataTableView setHidden:YES];
        [self.textFildTo setEnabled:YES];
    } else if (self.textFildTo.isEnabled) {
        self.textFildTo.text = [[self.geoObjektArray objectAtIndex:indexPath.row] geoName];
        self.geoObjektTo = [self.geoObjektArray objectAtIndex:indexPath.row];
        [self.geoDataTableView setHidden:YES];
        [self.textFildFrom setEnabled:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // If the viewController was pushed in a landscape orientation its frame was that of a portrait view yet, then we have to reset the
    // page curl view's mesh here.
    [self.pageDragView refreshPageCurlView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return !self.pageDragView.pageIsCurled;
}

- (BOOL)shouldAutorotate
{
    return !self.pageDragView.pageIsCurled;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    // After a rotation we have to reset the viewToCurl for the curling mesh to be updated.
    [self.pageDragView refreshPageCurlView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
