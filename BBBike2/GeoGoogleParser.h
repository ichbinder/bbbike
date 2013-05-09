//
//  GeoGoogleParser.h
//  BBBike
//
//  Created by Icke Horst on 26.04.13.
//  Copyright (c) 2013 Icke Horst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GeoObjekt.h"

@interface GeoGoogleParser : NSObject

@property (retain, nonatomic) NSMutableArray *geoObjektArray;
@property (retain, nonatomic) GeoObjekt *tempGeoObjekt;
@property (retain, nonatomic) NSString *address;
@property (retain, nonatomic) NSArray *geoData;

-(id) initWithAddress:(NSString*) address;
-(void) test;
@end
