//
//  GPKGMetadataDao.m
//  geopackage-ios
//
//  Created by Brian Osborn on 5/19/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import "GPKGMetadataDao.h"

@implementation GPKGMetadataDao

-(instancetype) initWithDatabase: (GPKGConnection *) database{
    self = [super initWithDatabase:database];
    if(self != nil){
        self.tableName = M_TABLE_NAME;
        self.idColumns = @[M_COLUMN_PK];
        self.columns = @[M_COLUMN_ID, M_COLUMN_SCOPE, M_COLUMN_STANDARD_URI, M_COLUMN_MIME_TYPE, M_COLUMN_METADATA];
        [self initializeColumnIndex];
    }
    return self;
}

-(NSObject *) createObject{
    return [[GPKGMetadata alloc] init];
}

-(void) setValueInObject: (NSObject*) object withColumnIndex: (int) columnIndex withValue: (NSObject *) value{
    
    GPKGMetadata *setObject = (GPKGMetadata*) object;
    
    switch(columnIndex){
        case 0:
            setObject.id = (NSNumber *) value;
            break;
        case 1:
            setObject.scope = (NSString *) value;
            break;
        case 2:
            setObject.standardUri = (NSString *) value;
            break;
        case 3:
            setObject.mimeType = (NSString *) value;
            break;
        case 4:
            setObject.metadata = (NSString *) value;
            break;
        default:
            [NSException raise:@"Illegal Column Index" format:@"Unsupported column index: %d", columnIndex];
            break;
    }
    
}

-(NSObject *) getValueFromObject: (NSObject*) object withColumnIndex: (int) columnIndex{
    
    NSObject * value = nil;
    
    GPKGMetadata *getObject = (GPKGMetadata*) object;
    
    switch(columnIndex){
        case 0:
            value = getObject.id;
            break;
        case 1:
            value = getObject.scope;
            break;
        case 2:
            value = getObject.standardUri;
            break;
        case 3:
            value = getObject.mimeType;
            break;
        case 4:
            value = getObject.metadata;
            break;
        default:
            [NSException raise:@"Illegal Column Index" format:@"Unsupported column index: %d", columnIndex];
            break;
    }
    
    return value;
}

-(int) deleteCascade: (GPKGMetadata *) metadata{
    int count = 0;
    
    if(metadata != nil){
        
        // Delete Metadata References and remove parent references
        // TODO
        
        // Delete
        count = [self delete:metadata];
    }
    
    return count;
}

-(int) deleteCascadeWithCollection: (NSArray *) metadataCollection{
    int count = 0;
    if(metadataCollection != nil){
        for(GPKGMetadata *metadata in metadataCollection){
            count += [self deleteCascade:metadata];
        }
    }
    return count;
}

-(int) deleteCascadeWhere: (NSString *) where{
    int count = 0;
    if(where != nil){
        GPKGResultSet *results = [self queryWhere:where];
        while([results moveToNext]){
            GPKGMetadata *metadata = (GPKGMetadata *)[self getObject:results];
            count += [self deleteCascade:metadata];
        }
        [results close];
    }
    return count;
}

-(int) deleteByIdCascade: (NSNumber *) id{
    int count = 0;
    if(id != nil){
        GPKGMetadata *metadata = (GPKGMetadata *) [self queryForIdObject:id];
        if(metadata != nil){
            count = [self deleteCascade:metadata];
        }
    }
    return count;
}

-(int) deleteIdsCascade: (NSArray *) idCollection{
    int count = 0;
    if(idCollection != nil){
        for(NSNumber * id in idCollection){
            count += [self deleteByIdCascade:id];
        }
    }
    return count;
}

// TODO
//-(GPKGMetadataReferenceDao *) getMetadataReferenceDao{
//    return [[GPKGMetadataReferenceDao alloc] initWithDatabase:self.database];
//}

@end