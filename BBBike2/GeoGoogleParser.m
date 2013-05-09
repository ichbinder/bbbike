//
//  GeoGoogleParser.m
//  BBBike
//
//  Created by Icke Horst on 26.04.13.
//  Copyright (c) 2013 Icke Horst. All rights reserved.
//

#import "GeoGoogleParser.h"
#import "GeoObjekt.h"
#import "SBJson.h"

@implementation GeoGoogleParser

@synthesize geoObjektArray = _geoObjektArray;
@synthesize address = _address;

-(id) initWithAddress:(NSString*) address
{
    self.address = address;
    self.geoObjektArray = [[NSMutableArray alloc] init];
    
    NSString *encodedAddress = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self.address, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
    
    NSString *urlString = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=false", encodedAddress];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if(error) {
        NSLog(@"Error no json data receive");
    } else {
        SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
        NSDictionary *jsonObjects = [jsonParser objectWithData:data];
        NSArray *geoData = [jsonObjects objectForKey:@"results"];
        if (geoData.count != 0) {
            for (NSInteger i = 0; i < geoData.count; i++) {
                GeoObjekt *tempGeoObjekt = [[GeoObjekt alloc] init];
                tempGeoObjekt.geoName = [[geoData objectAtIndex:(i)] objectForKey:@"formatted_address"];
                NSDictionary *tmpGeometry = [[geoData objectAtIndex:(i)] objectForKey:@"geometry"];
                NSDictionary *tmpLocation = [tmpGeometry objectForKey:@"location"];
                tempGeoObjekt.lat = [tmpLocation objectForKey:@"lat"];
                tempGeoObjekt.lng = [tmpLocation objectForKey:@"lng"];
                [self.geoObjektArray addObject:tempGeoObjekt];
            }
        } else {
            NSLog(@"Error no json data receive");
            GeoObjekt *nilGeoObjekt = [[GeoObjekt alloc] init];
            nilGeoObjekt.geoName = @"Nothing found.";
            nilGeoObjekt.lat = @"0.0f";
            nilGeoObjekt.lng = @"0.0f";
            [self.geoObjektArray addObject:nilGeoObjekt];
        }
        

    }

    /*
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSArray *geoData = [JSON objectForKey:@"results"];
        if (geoData != nil) {        
            for (NSInteger i = 0; i < geoData.count; i++) {
                GeoObjekt *tempGeoObjekt = [[GeoObjekt alloc] init];
                tempGeoObjekt.geoName = [[geoData objectAtIndex:(i)] objectForKey:@"formatted_address"];
                NSDictionary *tmpGeometry = [[geoData objectAtIndex:(i)] objectForKey:@"geometry"];
                NSDictionary *tmpLocation = [tmpGeometry objectForKey:@"location"];
                tempGeoObjekt.lat = [tmpLocation objectForKey:@"lat"];
                tempGeoObjekt.lng = [tmpLocation objectForKey:@"lng"];
                [self.geoObjektArray addObject:tempGeoObjekt];
            }
        } else {
            NSLog(@"Error no json data receive");
        }        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
    }];
    
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    [operationQueue addOperation:(operation)];
    [operationQueue waitUntilAllOperationsAreFinished];
    [operation 	start];
    while (![operation isFinished]) {

    }
    if ([operation isFinished])
        NSLog(@"yes");
    else
        NSLog(@"no");
    */
    return self;
}

-(void) test
{
    NSLog(@"lat: %@", [[self.geoObjektArray objectAtIndex:(0)] lat] );
}

@end
