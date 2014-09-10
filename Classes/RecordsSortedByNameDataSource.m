//
//  RecordsSortedByName.m
//  TheElements
//
//  Created by Developer on 08/09/14.
//
//

#import "RecordsSortedByNameDataSource.h"
#import "BookRecord.h"
#import "BookRecordCollection.h"
#import "BookRecordTableViewCell.h"


@implementation RecordsSortedByNameDataSource

UIViewController
// protocol methods for "ElementsDataSourceProtocol"

// return the data used by the navigation controller and tab bar item

- (NSString *)name {
    
	return @"Name";
}

- (NSString *)navigationBarName {
    
	return @"Sorted by Name";
}

- (UIImage *)tabBarImage {
    
	return [UIImage imageNamed:@"name_gray.png"];
}

- (UITableViewStyle)tableViewStyle {
    
	return UITableViewStylePlain;
}

// return the atomic element at the index
- (BookRecord *)bookRecordForIndexPath:(NSIndexPath *)indexPath {

    //if(indexPath.row >= 0 && indexPath.row <= 5)
    {
        BookRecord* bookRecord = [[[BookRecordCollection getBookRecordCollection] recordsArray ]
                                  objectAtIndex:indexPath.row];
        return bookRecord;
    }
    return nil;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	BookRecordTableViewCell *cell =
    (BookRecordTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"BookRecordCell"];
    
	// set the element for this cell as specified by the datasource. The atomicElementForIndexPath: is declared
	// as part of the ElementsDataSource Protocol and will return the appropriate element for the index row
    //
	cell.record = [self bookRecordForIndexPath:indexPath];
	
	return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
	// returns the array of section titles. There is one entry for each unique character that an element begins with
	// [A,B,C,D,E,F,G,H,I,K,L,M,N,O,P,R,S,T,U,V,X,Y,Z]
	return [[BookRecordCollection getBookRecordCollection] recordsNameIndexArray];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
	return index;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
	return [[[BookRecordCollection getBookRecordCollection] recordsArray ] count ];
                                          //recordsWithInitialLetter:initialLetter];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
	// this table has multiple sections. One for each unique character that an element begins with
	// [A,B,C,D,E,F,G,H,I,K,L,M,N,O,P,R,S,T,U,V,X,Y,Z]
	// return the letter that represents the requested section
	// this is actually a delegate method, but we forward the request to the datasource in the view controller
	//
	return [[[BookRecordCollection getBookRecordCollection] recordsNameIndexArray]
            objectAtIndex:section];
}

@end
