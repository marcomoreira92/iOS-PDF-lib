//
//	ReaderMainToolbar.m
//	Reader v2.8.6
//
//	Created by Julius Oklamcak on 2011-07-01.
//	Copyright © 2011-2015 Julius Oklamcak. All rights reserved.
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights to
//	use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
//	of the Software, and to permit persons to whom the Software is furnished to
//	do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in all
//	copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
//	OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//	CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "ReaderConstants.h"
#import "ReaderMainToolbar.h"
#import "ReaderDocument.h"
#import "SearchHolder.h"
#import "Scanner.h"
#import "Constants.h"

#import <MessageUI/MessageUI.h>

@implementation ReaderMainToolbar
{
    UIButton *markButton;
    
    UIImage *markImageN;
    UIImage *markImageY;
}

#pragma mark - Constants

#define BUTTON_X 8.0f
#define BUTTON_Y 8.0f

#define BUTTON_SPACE 8.0f
#define BUTTON_HEIGHT 30.0f

#define BUTTON_FONT_SIZE 15.0f
#define TEXT_BUTTON_PADDING 24.0f

#define ICON_BUTTON_WIDTH 44.0f

#define TITLE_FONT_SIZE 19.0f
#define TITLE_HEIGHT 44.0f

#pragma mark - Properties

@synthesize delegate;

#pragma mark - ReaderMainToolbar instance methods

UIButton *doneButton;
UIButton *searchButton;
UIButton *thumbsButton;
UISearchBar *searchbar;

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame document:nil];
}

- (instancetype)initWithFrame:(CGRect)frame document:(ReaderDocument *)document
{
    assert(document != nil); // Must have a valid ReaderDocument
    
    if ((self = [super initWithFrame:frame]))
    {
        CGFloat viewWidth = self.bounds.size.width; // Toolbar view width
        UIImage *buttonH = nil; UIImage *buttonN = nil;
        BOOL largeDevice = ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad);
        const CGFloat buttonSpacing = BUTTON_SPACE;
        const CGFloat iconButtonWidth = ICON_BUTTON_WIDTH;
        CGFloat titleX = BUTTON_X;
        CGFloat titleWidth = (viewWidth - (titleX + titleX));
        CGFloat leftButtonX = BUTTON_X; // Left-side button start X position
        //CGFloat rightButtonX = viewWidth; // Right-side buttons start X position

        self.backgroundColor = [UIColor colorWithRed: [Constants getRedColorComponent] green: [Constants getGreenColorComponent] blue:[Constants getBlueColorComponent] alpha:1]; // toolbar background
        
        

        //init done button
        UIFont *doneButtonFont = [UIFont systemFontOfSize:BUTTON_FONT_SIZE];
        NSString *doneButtonText = NSLocalizedString(@"Done", @"button");
        CGSize doneButtonSize = [doneButtonText sizeWithFont:doneButtonFont];
        CGFloat doneButtonWidth = (doneButtonSize.width + TEXT_BUTTON_PADDING);
        
        doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        doneButton.frame = CGRectMake(leftButtonX, BUTTON_Y, doneButtonWidth, BUTTON_HEIGHT);
        [doneButton setTitleColor:[UIColor colorWithWhite:1.0f alpha:1.0f] forState:UIControlStateNormal];
        [doneButton setTitleColor:[UIColor colorWithWhite:0.8f alpha:1.0f] forState:UIControlStateHighlighted];  //Touch feedback !
        [doneButton setTitle:doneButtonText forState:UIControlStateNormal];
        doneButton.titleLabel.font = doneButtonFont;
        [doneButton addTarget:self action:@selector(doneButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [doneButton setBackgroundImage:buttonH forState:UIControlStateHighlighted];
        [doneButton setBackgroundImage:buttonN forState:UIControlStateNormal];
        doneButton.autoresizingMask = UIViewAutoresizingNone;
        //doneButton.backgroundColor = [UIColor grayColor];
        doneButton.exclusiveTouch = YES;
        
        [self addSubview:doneButton];
        leftButtonX += (doneButtonWidth + buttonSpacing);
        titleX += (doneButtonWidth + buttonSpacing);
        titleWidth -= (doneButtonWidth + buttonSpacing);
        


        
        // init thumbs button
        thumbsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        thumbsButton.frame = CGRectMake(leftButtonX, BUTTON_Y, iconButtonWidth, BUTTON_HEIGHT);
        [thumbsButton setImage:[UIImage imageNamed:@"Reader-Thumbs"] forState:UIControlStateNormal];
        [thumbsButton addTarget:self action:@selector(thumbsButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [thumbsButton setBackgroundImage:buttonH forState:UIControlStateHighlighted];
        [thumbsButton setBackgroundImage:buttonN forState:UIControlStateNormal];
        thumbsButton.autoresizingMask = UIViewAutoresizingNone;
        //thumbsButton.backgroundColor = [UIColor grayColor];
        thumbsButton.exclusiveTouch = YES;
        
        [self addSubview:thumbsButton];
        leftButtonX += (iconButtonWidth + buttonSpacing);
        

        
        
        // init search button
        searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        searchButton.frame = CGRectMake(leftButtonX, BUTTON_Y, iconButtonWidth, BUTTON_HEIGHT);
        [searchButton setImage:[UIImage imageNamed:@"Reader-Search"] forState:UIControlStateNormal];
        [searchButton addTarget:self action:@selector(searchButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [searchButton setBackgroundImage:buttonH forState:UIControlStateHighlighted];
        [searchButton setBackgroundImage:buttonN forState:UIControlStateNormal];
        searchButton.autoresizingMask = UIViewAutoresizingNone;
        //thumbsButton.backgroundColor = [UIColor grayColor];
        searchButton.exclusiveTouch = YES;
        
        [self addSubview:searchButton];
        leftButtonX += (iconButtonWidth + buttonSpacing);
        
        
        
        
        
        
        // init search bar
        //rightButtonX -= (iconButtonWidth*6 + buttonSpacing); // Position
        searchbar = [[UISearchBar alloc] init];
        searchbar.searchBarStyle = UISearchBarStyleMinimal;
        searchbar.showsCancelButton = YES;
        searchbar.tintColor = [UIColor whiteColor];
        [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        searchbar.delegate = self;
        searchbar.frame = CGRectMake(BUTTON_X, BUTTON_Y, (iconButtonWidth*6), BUTTON_HEIGHT);
        searchbar.hidden = YES;
        
        
        [self addSubview:searchbar];
        titleWidth -= (iconButtonWidth*3 + buttonSpacing);
        
        
    }
    
    return self;
}



- (void)updateBookmarkImage
{/*
  #if (READER_BOOKMARKS == TRUE) // Option
  
  if (markButton.tag != NSIntegerMin) // Valid tag
  {
		BOOL state = markButton.tag; // Bookmarked state
  
		UIImage *image = (state ? markImageY : markImageN);
  
		[markButton setImage:image forState:UIControlStateNormal];
  }
  
  if (markButton.enabled == NO) markButton.enabled = YES;
  
  #endif // end of READER_BOOKMARKS Option*/
}

- (void)hideToolbar
{
    if (self.hidden == NO)
    {
        [UIView animateWithDuration:0.25 delay:0.0
                            options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                         animations:^(void)
         {
             self.alpha = 0.0f;
         }
                         completion:^(BOOL finished)
         {
             self.hidden = YES;
         }
         ];
         [self endEditing:YES];
    }
}

- (void)showToolbar
{
    if (self.hidden == YES)
    {
        [self updateBookmarkImage]; // First
        
        [UIView animateWithDuration:0.25 delay:0.0
                            options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                         animations:^(void)
         {
             self.hidden = NO;
             self.alpha = 1.0f;
         }
                         completion:NULL
         ];
    }
}

#pragma mark - UIButton action methods

- (void)doneButtonTapped:(UIButton *)button
{
    [delegate tappedInToolbar:self doneButton:button];
}

- (void)thumbsButtonTapped:(UIButton *)button
{
    [delegate tappedInToolbar:self thumbsButton:button];
}
- (void)searchButtonTapped:(UIButton *)button
{
    
      searchbar.hidden = NO;
      doneButton.hidden = YES;
      thumbsButton.hidden = YES;
      searchButton.hidden = YES;
     [searchbar becomeFirstResponder ];
}



- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
  
    searchbar.hidden = YES;
    doneButton.hidden = NO;
    thumbsButton.hidden = NO;
    searchButton.hidden = NO;
    [self endEditing:YES];
    [searchbar resignFirstResponder ];
    
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if([searchText isEqualToString:@""]){
        [SearchHolder setKeyword:nil];
        ReaderContentPage *reader = [SearchHolder getReaderContentPage];
        [reader setNeedsDisplay];
    }
    
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    NSLog(@"searchBarTextDidEndEditing");
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{


    
    
    [delegate doSearch: searchbar.text];
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchBarTextDidBeginEditing");
}



@end
