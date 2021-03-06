//
//  RecordsSortedByName.m
//  TheElements
//
//  Created by Developer on 08/09/14.
//
//

#import "TableDataSource.h"
#import "BookRecord.h"
#import "BookRecordCollection.h"
#import "BookRecordTableViewCell.h"

@interface TableDataSource()
@end


@implementation TableDataSource

- (NSString *)name {
    
	return @"";
}

- (NSString *)navigationBarName {
    
	return @"Address Book";
}

- (UITableViewStyle)tableViewStyle {
    
	return UITableViewStylePlain;
}

- (BookRecord *)bookRecordForIndexPath:(NSIndexPath *)indexPath {
   NSString* keyByIndex = [[[BookRecordCollection getInstance]
                          recordsNameIndexArray ] objectAtIndex:(indexPath.section)];
   BookRecord* bookRecord = [(NSArray*)[[[BookRecordCollection getInstance]
                             recordsDictionary ] objectForKey:( keyByIndex )] objectAtIndex:(indexPath.row)];
   return bookRecord;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	BookRecordTableViewCell *cell =
    (BookRecordTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"BookRecordCell"];

	cell.record = [self bookRecordForIndexPath:indexPath];
	   
	return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [[[BookRecordCollection getInstance] recordsNameIndexArray] count ];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
	// returns the array of section titles. There is one entry for each unique character that an element begins with
	// [A,B,C,D,E,F,G,H,I,K,L,M,N,O,P,R,S,T,U,V,X,Y,Z]
	return [[BookRecordCollection getInstance] recordsNameIndexArray];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
	return index;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id aKey = [[[BookRecordCollection getInstance] recordsNameIndexArray ] objectAtIndex:section];
    id aDictValue = [[[BookRecordCollection getInstance] recordsDictionary ] objectForKey:aKey];
    return [aDictValue count];

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
	// this table has multiple sections. One for each unique character that an element begins with
	// [A,B,C,D,E,F,G,H,I,K,L,M,N,O,P,R,S,T,U,V,X,Y,Z]
	// return the letter that represents the requested section
	return [[[BookRecordCollection getInstance] recordsNameIndexArray]
            objectAtIndex:section];
}

-(void)setRecordAtIndex:(NSIndexPath*)indexPath
                record :(BookRecord*)bookRecord
{
    NSString* keyByIndex = [[[BookRecordCollection getInstance]
                             recordsNameIndexArray ] objectAtIndex:(indexPath.section)];
    [(NSMutableOrderedSet*)[[[BookRecordCollection getInstance]
                              recordsDictionary    ] objectForKey        :(keyByIndex)]
                                                     replaceObjectAtIndex:indexPath.row
                                                     withObject          :bookRecord];
    
}


@end
