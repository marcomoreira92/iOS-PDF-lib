//
//  Search.m
//  PDF Lib
//
//  Created by Marco Moreira on 11/09/16.
//  Copyright © 2016 MarcoMoreira92. All rights reserved.
//

#import "SearchHolder.h"
#import "ReaderContentPage.h"

@implementation SearchHolder

static NSString * searchKeyword;
static ReaderContentPage * readerContentP;
static int searchOcurrence = -1;
static int numberOfPages = 0;
static int numberOfPagesAlreadySearched = 0;


+ (NSString *)getKeywords{
    return searchKeyword;
}
+ (void)setKeyword:(NSString *)keyword {
    searchKeyword = keyword;
}



+(ReaderContentPage *) getReaderContentPage{
    return readerContentP;
}

+ (void)setReaderContentPage:(ReaderContentPage *)readerContentPage {
    readerContentP = readerContentPage;
}




+ (int) getSearchOcurrence{
    return searchOcurrence;
}
+ (void)setSearchOcurrence:(int)ocurrence {
    searchOcurrence = ocurrence;
}
+ (void)incrementSearchOcurrence:(int)ocurrence {
    searchOcurrence += ocurrence;
}




+ (int) getNumberOfPagesToSearch{
    return numberOfPages;
}
+ (void) setNumberOfPagesToSearch:(int) pageNumber{
    numberOfPages = pageNumber;
}




+ (int) getNumberOfPagesAllreadySeached{
    return numberOfPagesAlreadySearched;
}
+ (void) setNumberOfPagesAllreadySeached:(int) pageNumber{
    numberOfPagesAlreadySearched = pageNumber;
}
+ (void)incrementNumberOfPagesAllreadySeached{
    numberOfPagesAlreadySearched +=1;
}


@end
