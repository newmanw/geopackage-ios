//
//  GPKGGeoPackageGeometryDataUtils.h
//  geopackage-ios
//
//  Created by Brian Osborn on 6/9/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPKGBaseTestCase.h"
#import "GPKGGeoPackage.h"

@interface GPKGGeoPackageGeometryDataUtils : NSObject

+(void) testReadWriteBytesWithGeoPackage: (GPKGGeoPackage *) geoPackage;

+(void) testGeometryProjectionTransform: (GPKGGeoPackage *) geoPackage;

+(void) compareByteArrayWithExpected: (NSData *) expected andActual: (NSData *) actual;

@end
