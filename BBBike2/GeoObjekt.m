//
//  GeoObjekt.m
//  BBBike
//
//  Created by Icke Horst on 26.04.13.
//  Copyright (c) 2013 Icke Horst. All rights reserved.
//

#import "GeoObjekt.h"

@implementation GeoObjekt

@synthesize geoName = _geoName;
@synthesize lat = _lat;
@synthesize lng = _lng;

-(id) initWithGeoName:(NSString*) geoName longitude:(NSString*) lng latitude:(NSString*) lat
{
    self = [super init];
    self.geoName = geoName;
    self.lat = lat;
    self.lng = lng;
    
    return self;
}

@end
