//
//  GraphicsHeader.h
//  The Vike
//
//  Created by Brian Tracy on 3/14/15.
//  Copyright (c) 2015 Silicode. All rights reserved.
//

#ifndef The_Vike_GraphicsHeader_h
#define The_Vike_GraphicsHeader_h

#import <UIKit/UIScreen.h>


#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


#define SCREEN_WIDTH_OVER(num) (SCREEN_WIDTH / num)
#define SCREEN_HEIGHT_OVER(num) (SCREEN_HEIGHT / num)


#endif
