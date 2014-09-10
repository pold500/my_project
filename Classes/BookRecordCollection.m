//
//  BookRecordCollection.m
//  TheElements
//
//  Created by Developer on 05/09/14.
//
//

#import "BookRecordCollection.h"
#import "BookRecord.h"

@implementation BookRecordCollection

static BookRecordCollection *sharedInstance = nil;

+(BookRecordCollection*)getBookRecordCollection
{
    @synchronized(self) {
        static dispatch_once_t pred;
        dispatch_once(&pred, ^{ sharedInstance = [[self alloc] init]; });
    }
    return sharedInstance;
}

+(NSArray*)constructIndexArray:(NSArray*)sortedNamesArray
{
    NSMutableArray *indexArray = [[NSMutableArray alloc]init];
    for(size_t i=0; i<sortedNamesArray.count; i++)
    {
        [indexArray addObject:[[[sortedNamesArray objectAtIndex:(i)] name ] substringToIndex:(1)] ];
    }
    return indexArray;
    
}

+(NSArray*)sortStringAlphabetically:(NSArray*)arrayToSort
{
    NSArray *sortedArray;
    sortedArray = [arrayToSort sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSString *first  = a;
        NSString *second = b;
        return [first compare:second];
    }];
    return sortedArray;
}

+(NSArray*)presortRecordsByName:(NSArray*)arrayToBeSorted
{
    NSArray *sortedArray;
    sortedArray = [arrayToBeSorted sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSString *first  = [(BookRecord*)a name];
        NSString *second = [(BookRecord*)b name];
        return [first compare:second];
    }];
    return sortedArray;
}

+(NSMutableDictionary*)constructRecordsDictionaryByIndex:(NSArray*)indexArray
                       sortedRecordsArray:(NSArray*)sortedRecordsArray
{
    NSMutableDictionary* dict = [[NSMutableDictionary alloc]init];
    for(size_t i=0; i<indexArray.count; i++)
    {
        NSMutableArray* array = [[NSMutableArray alloc]initWithCapacity:10];
        for(size_t j=0; j<sortedRecordsArray.count; j++)
        {
            if ([[[[sortedRecordsArray objectAtIndex:j] name] substringToIndex:(1)] isEqualToString:(indexArray[i])]) {
                [array addObject:sortedRecordsArray[j]];
            }
            
        }
    }
    return dict;
}

- (void)setupRecordsArray {
    
	NSDictionary *eachElement;

	// read the element data from the plist
	NSString *thePath = [[NSBundle mainBundle]  pathForResource:@"BookRecords" ofType:@"plist"];
	NSArray  *bookRecordsFromFileDictionary = [[NSArray alloc] initWithContentsOfFile:thePath];
    
	// iterate over the values in the raw elements dictionary
	for (eachElement in bookRecordsFromFileDictionary)
	{
        //[myObject isKindOfClass:[NSString class]]
		// create an Book Record instance for each
        BookRecord *aRecord = [[BookRecord alloc] init];
        if ([eachElement isKindOfClass:[NSDictionary class]])
		    aRecord = [[BookRecord alloc] initWithDictionary:eachElement];
		if ([eachElement isKindOfClass:[NSString class]]) {
            aRecord = nil;
            [NSException raise:@"Invalid value" format:@"Object type is invalid"];
        }
        
        [self.recordsArray      addObject: aRecord]; //unsorted, without any order
        
        id object = [self.recordsDictionary objectForKey:[aRecord.name substringToIndex:1]];
        if (object!=nil) {
            NSMutableArray *array = (NSMutableArray*)object;
            [array addObject:aRecord];
        } else {
            NSMutableArray* recordsArray = [[NSMutableArray alloc] init];
            [recordsArray addObject:aRecord];
            [self.recordsDictionary setValue:recordsArray forKey:[aRecord.name substringToIndex:1]];
        }

		
    }
    NSArray* keys = [self.recordsDictionary allKeys];
    for(NSString *key in keys)
    {
        NSMutableArray* arr = [self.recordsDictionary objectForKey:key];
        [self.recordsDictionary setValue:(NSMutableArray*)[BookRecordCollection presortRecordsByName:arr] forKey:key];
        
    }
    
//  self.recordsSortedByName   = [BookRecordCollection presortRecordsByName: self.recordsArray       ];
    self.recordsNameIndexArray = [BookRecordCollection sortStringAlphabetically:self.recordsDictionary.allKeys];
   
  
    
    //self.recordsDictionary = [BookRecordCollection constructRecordsDictionaryByIndex:self.recordsNameIndexArray :
    //                                       self.recordsSortedByName];
}

// setup the data collection
- (id) init {
	if (self = [super init]) {
        self.recordsDictionary   = [[ NSMutableDictionary alloc] init];
   		[self setupRecordsArray];
	}
	return self;
}





@end
