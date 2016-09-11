//
//	ThumbsMainToolbar.m
//	Reader v2.8.6
//
//	Created by Julius Oklamcak on 2011-09-01.
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
#import "ThumbsMainToolbar.h"
#import "Constants.h"
@implementation ThumbsMainToolbar

#pragma mark - Constants

#define BUTTON_X 8.0f
#define BUTTON_Y 8.0f

#define BUTTON_SPACE 8.0f
#define BUTTON_HEIGHT 30.0f

#define BUTTON_FONT_SIZE 15.0f
#define TEXT_BUTTON_PADDING 24.0f

#define SHOW_CONTROL_WIDTH 78.0f
#define ICON_BUTTON_WIDTH 40.0f

#define TITLE_FONT_SIZE 19.0f
#define TITLE_HEIGHT 28.0f

#pragma mark - Properties

@synthesize delegate;

#pragma mark - ThumbsMainToolbar instance methods

- (instancetype)initWithFrame:(CGRect)frame
{
	return [self initWithFrame:frame title:nil];
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title
{
	if ((self = [super initWithFrame:frame]))
	{
		CGFloat viewWidth = self.bounds.size.width; // Toolbar view width
		UIImage *buttonH = nil; UIImage *buttonN = nil;

		BOOL largeDevice = ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad);

		const CGFloat buttonSpacing = BUTTON_SPACE; //const CGFloat iconButtonWidth = ICON_BUTTON_WIDTH;

		CGFloat titleX = BUTTON_X; CGFloat titleWidth = (viewWidth - (titleX + titleX));
        self.backgroundColor = [UIColor colorWithRed: [Constants getRedColorComponent] green: [Constants getGreenColorComponent] blue:[Constants getBlueColorComponent] alpha:1]; // toolbar background
		CGFloat leftButtonX = BUTTON_X; // Left-side button start X position

		UIFont *doneButtonFont = [UIFont systemFontOfSize:BUTTON_FONT_SIZE];
		NSString *doneButtonText = NSLocalizedString(@"Done", @"button");
		CGSize doneButtonSize = [doneButtonText sizeWithFont:doneButtonFont];
		CGFloat doneButtonWidth = (doneButtonSize.width + TEXT_BUTTON_PADDING);

		UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
		doneButton.frame = CGRectMake(leftButtonX, BUTTON_Y, doneButtonWidth, BUTTON_HEIGHT);
		[doneButton setTitleColor:[UIColor colorWithWhite:1.0f alpha:1.0f] forState:UIControlStateNormal];
		[doneButton setTitleColor:[UIColor colorWithWhite:0.7f alpha:1.0f] forState:UIControlStateHighlighted];
		[doneButton setTitle:doneButtonText forState:UIControlStateNormal]; doneButton.titleLabel.font = doneButtonFont;
		[doneButton addTarget:self action:@selector(doneButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
		[doneButton setBackgroundImage:buttonH forState:UIControlStateHighlighted];
		[doneButton setBackgroundImage:buttonN forState:UIControlStateNormal];
		doneButton.autoresizingMask = UIViewAutoresizingNone;
		//doneButton.backgroundColor = [UIColor grayColor];
		doneButton.exclusiveTouch = YES;

		[self addSubview:doneButton]; //leftButtonX += (doneButtonWidth + buttonSpacing);

		titleX += (doneButtonWidth + buttonSpacing); titleWidth -= (doneButtonWidth + buttonSpacing);


	}

	return self;
}

#pragma mark - UISegmentedControl action methods

- (void)showControlTapped:(UISegmentedControl *)control
{
	[delegate tappedInToolbar:self showControl:control];
}

#pragma mark - UIButton action methods

- (void)doneButtonTapped:(UIButton *)button
{
	[delegate tappedInToolbar:self doneButton:button];
}

@end
