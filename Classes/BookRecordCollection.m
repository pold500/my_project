//
//  BookRecordCollection.m
//  TheElements
//
//  Created by Developer on 05/09/14.
//
//

#import "BookRecordCollection.h"
#import "BookRecord.h"

@interface BookRecordCollection()

@property (nonatomic, strong) NSMutableArray      *recordsArray;
@property (nonatomic, strong) NSArray             *recordsSortedByName;

@end

@implementation BookRecordCollection

static BookRecordCollection *sharedInstance = nil;

+(BookRecordCollection*)getInstance
{
    @synchronized(self) {
        static dispatch_once_t pred;
        dispatch_once(&pred, ^{ sharedInstance = [[self alloc] init]; });
    }
    return sharedInstance;
}

//Helper static private method
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

- (void)setupRecordsArray {
    
	NSDictionary *eachElement;

	// Read the element data from the plist
	NSString *thePath = [[NSBundle mainBundle]  pathForResource:@"BookRecords" ofType:@"plist"];
	NSArray  *bookRecordsFromFileDictionary = [[NSArray alloc] initWithContentsOfFile:thePath];

	// Iterate over the values in the raw array, representing the contents of a file
	for (eachElement in bookRecordsFromFileDictionary)
	{
        BookRecord *aRecord = [[BookRecord alloc] init];

        aRecord = [[BookRecord alloc] initWithDictionary:eachElement];

        [self.recordsArray      addObject: aRecord]; //unsorted, without any order
        
        id object = [self.recordsDictionary objectForKey:[aRecord.name substringToIndex:1]];

        if (object!=nil) {

            NSMutableOrderedSet* orderedSet = (NSMutableOrderedSet*)object;
            [orderedSet addObject:aRecord];

        } else {

            NSMutableOrderedSet* orderedSet = [[NSMutableOrderedSet alloc] initWithObject:aRecord];
            [self.recordsDictionary setValue:orderedSet forKey:[aRecord.name substringToIndex:1]];

        }

		[self.recordsArrayById addObject:(aRecord)];

    }

    self.recordsNameIndexArray = [BookRecordCollection sortStringAlphabetically:self.recordsDictionary.allKeys];
    
}

- (BookRecord *)getBookRecordForIndexPath:(NSIndexPath *)indexPath {
    NSString* keyByIndex = [[[BookRecordCollection getInstance                       ]
                                                   recordsNameIndexArray             ]
                                                   objectAtIndex:(indexPath.section) ];
    BookRecord* bookRecord = [(NSArray*)[[[BookRecordCollection getInstance  ]
                                           recordsDictionary                 ]
                                           objectForKey     :(keyByIndex   ) ]
                                           objectAtIndex    :(indexPath.row) ];
    return bookRecord;
}

-(void)setBookRecordForIndexPath:(NSIndexPath *) indexPath
                          record:(BookRecord  *) bookRecord {
    NSString* keyFromFirstLetter = [bookRecord.name substringToIndex:1];
    keyFromFirstLetter = keyFromFirstLetter.uppercaseString;

    //1. Check if such key exists in the dictionary
    if([[[BookRecordCollection getInstance        ] recordsDictionary ]
                               objectForKey:keyFromFirstLetter]!=nil)
    {
        //2. If such a key exists:
        //   get the Key of the bin where the needed record is stored
        NSString* keyByIndex = [[[BookRecordCollection getInstance]
                                 recordsNameIndexArray ] objectAtIndex:(indexPath.section)];
        
        //3. Remove an old, outdated object, from that bin
         [[[[BookRecordCollection getInstance] recordsDictionary] objectForKey:keyByIndex ]
             removeObjectAtIndex:(indexPath.row)];
        //4. Add the new object, constructed from the old, at a given key into a given bin
        [(NSMutableOrderedSet*)[[[BookRecordCollection getInstance]
                                 recordsDictionary ] objectForKey:( keyFromFirstLetter )] addObject:bookRecord];

    }
    else {
        // Such a key doesn't exists, so we need to update a recordsNameIndexArray
        //   after we update the main struct
        // 1. Calculate the key in a dictionary
        NSString* keyByIndex = [[[BookRecordCollection getInstance]
                                 recordsNameIndexArray ] objectAtIndex:(indexPath.section)];
        //2. Remove and old, outdated object from it's position in a table
        [[[[BookRecordCollection getInstance] recordsDictionary] objectForKey:keyByIndex ]
            removeObjectAtIndex:(indexPath.row)];
        //3. Get the bin where the record is stored
        NSMutableOrderedSet* orderedSet = [[NSMutableOrderedSet alloc] initWithObject:bookRecord];
        //4. Insert new element
        [[[BookRecordCollection getInstance        ]
                                recordsDictionary  ]
                                setValue:orderedSet
                                forKeyPath:( keyFromFirstLetter )] ;
        //5. Sort the keys of the newly updated dictionary alphabetically
        //6. Update sorted keys array in the main data model
        [[BookRecordCollection    getInstance] setRecordsNameIndexArray:
        [[[[BookRecordCollection  getInstance] recordsDictionary        ]
                                  allKeys    ] sortedArrayUsingComparator:
                                   ^NSComparisonResult(NSString* obj1, NSString* obj2)
        {
            return [obj1 localizedCaseInsensitiveCompare:obj2];
        }]];


        
    }

 
}

// setup the data collection
- (id) init {
	if (self = [super init]) {
        self.recordsDictionary   = [[NSMutableDictionary alloc] init];
        self.recordsArrayById    = [[NSMutableArray      alloc] init];
   		[self setupRecordsArray];
	}
	return self;
}





@end
