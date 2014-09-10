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

+(NSArray*)presortRecordsByName:(NSArray*)arrayToBeSorted
{
    return [arrayToBeSorted sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (void)setupRecordsArray {
    
	NSDictionary *eachElement;
	
//	// create dictionaries that contain the arrays of element data indexed by
//	// name
//	self.elementsDictionary = [NSMutableDictionary dictionary];
//	// physical state
//	self.statesDictionary = [NSMutableDictionary dictionary];
//	// unique first characters (for the Name index table)
//	self.nameIndexesDictionary = [NSMutableDictionary dictionary];
//    
//	// create empty array entries in the states Dictionary or each physical state
//	[self.statesDictionary setObject:[NSMutableArray array] forKey:@"Solid"];
//	[self.statesDictionary setObject:[NSMutableArray array] forKey:@"Liquid"];
//	[self.statesDictionary setObject:[NSMutableArray array] forKey:@"Gas"];
//	[self.statesDictionary setObject:[NSMutableArray array] forKey:@"Artificial"];
	
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
        
        [self.recordsArray addObject: aRecord];
		
        // store that item in the elements dictionary with the name as the key
		[self.namesDictionary setObject:aRecord forKey:aRecord.name];
		
		// add that element to the appropriate array in the physical state dictionary
		[[self.phonesDictionary objectForKey:aRecord.phoneNumber] addObject:aRecord];
		
		// get the element's initial letter
		//NSString *firstLetter = [anElement.name substringToIndex:1];
		//NSMutableArray *existingArray = [self.nameIndexesDictionary valueForKey:firstLetter];
        
		// if an array already exists in the name index dictionary
		// simply add the element to it, otherwise create an array
		// and add it to the name index dictionary with the letter as the key
        //
//		if (existingArray != nil)
//		{
//            [existingArray addObject:anElement];
//		} else {
//			NSMutableArray *tempArray = [NSMutableArray array];
//			[self.nameIndexesDictionary setObject:tempArray forKey:firstLetter];
//			[tempArray addObject:anElement];
//		}
	}
	
	// create the dictionary containing the possible element states
	// and presort the states data
	//self.elementPhysicalStatesArray = [NSArray arrayWithObjects:@"Solid", @"Liquid", @"Gas", @"Artificial", nil];
    //[self presortElementsByPhysicalState];
	
	// presort the dictionaries now
	// this could be done the first time they are requested instead
	//
	
    self.recordsSortedByName = [BookRecordCollection presortRecordsByName: self.recordsSortedByName];
	//self.elementsSortedByNumber = [self presortElementsByNumber];
	//self.elementsSortedBySymbol = [self presortElementsBySymbol];
}

// setup the data collection
- (id) init {
	if (self = [super init]) {
        self.namesDictionary  = [[NSMutableDictionary alloc] init];
        self.recordsArray     = [[NSMutableArray      alloc] init];
        self.phonesDictionary = [[NSMutableDictionary alloc] init];
		[self setupRecordsArray];
	}
	return self;
}

//
// presort the elementsSortedByNumber array
- (NSArray *)presortRecordsByNumber {
    
	NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"phoneNumber"
																 ascending:YES
																 selector:@selector(compare:)] ;
	
	NSArray *descriptors    = [ NSArray arrayWithObject:nameDescriptor ];
	NSArray *sortedElements = [[self.phonesDictionary allValues] sortedArrayUsingDescriptors:descriptors];
	return sortedElements;
}



@end
