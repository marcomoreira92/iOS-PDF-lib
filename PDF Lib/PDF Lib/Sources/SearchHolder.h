//
//  Search.h
//  PDF Lib
//
//  Created by Marco Moreira on 11/09/16.
//  Copyright © 2016 MarcoMoreira92. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReaderContentPage.h"

@interface SearchHolder : NSObject
    + (NSString *)getKeywords;
    + (void)setKeyword:(NSString *)keyword ;

    + (ReaderContentPage *) getReaderContentPage;
    + (void)setReaderContentPage:(ReaderContentPage *)readerContentPage ;

    + (int) getSearchOcurrence;
    + (void)setSearchOcurrence:(int)ocurrence ;
    + (void)incrementSearchOcurrence:(int)ocurrence;

    + (int) getNumberOfPagesToSearch;
    + (void) setNumberOfPagesToSearch:(int) pageNumber;

    + (int) getNumberOfPagesAllreadySeached;
    + (void) setNumberOfPagesAllreadySeached:(int) pageNumber;
    + (void)incrementNumberOfPagesAllreadySeached;

@end
