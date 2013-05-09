//
//  GeoObjekt.h
//  BBBike
//
//  Created by Icke Horst on 26.04.13.
//  Copyright (c) 2013 Icke Horst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GeoObjekt : NSObject

@property (retain, nonatomic) NSString *geoName;
@property (retain, nonatomic) NSString *lat;
@property (retain, nonatomic) NSString *lng;

-(id) initWithGeoName:(NSString*) geoName longitude:(NSString*) lng latitude:(NSString*) lat;

@end
