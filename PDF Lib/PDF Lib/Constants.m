//
//  Constants.m
//  PDF Lib
//
//  Created by Marco Moreira on 11/09/16.
//  Copyright © 2016 MarcoMoreira92. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@implementation Constants : NSObject

    //Change this color components to costumize the Reader color
    static float redColor   = 0.17;
    static float blueColor  = 0.86;
    static float greenColor = 0.54;

+ (float)getRedColorComponent{
    return redColor;
}
+ (float)getBlueColorComponent{
    return blueColor;
}
+ (float)getGreenColorComponent{
    return greenColor;
}

@end
