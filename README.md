# VHBoomMenuButton 

[![WoWoViewPager](https://github.com/Nightonke/WoWoViewPager/blob/master/app/src/main/res/mipmap-hdpi/ic_launcher.png?raw=true)](https://github.com/Nightonke/WoWoViewPager)
[![BoomMenu](https://github.com/Nightonke/BoomMenu/blob/master/app/src/main/res/mipmap-hdpi/ic_launcher.png?raw=true)](https://github.com/Nightonke/BoomMenu)
[![CoCoin](https://github.com/Nightonke/CoCoin/blob/master/app/src/main/res/mipmap-hdpi/ic_launcher.png?raw=true)](https://github.com/Nightonke/CoCoin)
[![BlurLockView](https://github.com/Nightonke/BlurLockView/blob/master/app/src/main/res/mipmap-hdpi/ic_launcher.png?raw=true)](https://github.com/Nightonke/BlurLockView)
[![LeeCo](https://github.com/Nightonke/LeeCo/blob/master/app/src/main/res/mipmap-hdpi/ic_launcher.png?raw=true)](https://github.com/Nightonke/LeeCo)
[![GithubWidget](https://github.com/Nightonke/GithubWidget/blob/master/app/src/main/res/mipmap-hdpi/ic_launcher.png?raw=true)](https://github.com/Nightonke/GithubWidget)
[![JellyToggleButton](https://github.com/Nightonke/JellyToggleButton/blob/master/app/src/main/res/mipmap-hdpi/ic_launcher.png?raw=true)](https://github.com/Nightonke/JellyToggleButton)
[![FaceOffToggleButton](https://github.com/Nightonke/FaceOffToggleButton/blob/master/app/src/main/res/mipmap-hdpi/ic_launcher.png?raw=true)](https://github.com/Nightonke/FaceOffToggleButton)

![](https://github.com/Nightonke/VHBoomMenuButton/blob/master/VHBoomMenuButtonPictures/Gif_0.gif?raw=true)
![](https://github.com/Nightonke/VHBoomMenuButton/blob/master/VHBoomMenuButtonPictures/Gif_1.gif?raw=true)  
![](https://github.com/Nightonke/VHBoomMenuButton/blob/master/VHBoomMenuButtonPictures/Gif_2.gif?raw=true)
![](https://github.com/Nightonke/VHBoomMenuButton/blob/master/VHBoomMenuButtonPictures/Gif_3.gif?raw=true)  

#Guide

[中文文档]()  
[Pod]()  
[Note]()

###Usage
1. [Basic Usage]()
2. [Boom Buttons]()
    1. [Simple Circle Button]()
    2. [Text Inside Circle Button]()
    3. [Text Outside Circle Button]()
    4. [Ham Button]()
3. [Boom Types]()
4. [Button Place Alignments]()
5. [Ease Types]()
6. [Background Dim]()
7. [Auto Hide]()
8. [NoBackground]()
9. [Draggable]()
10. [Frames, Duration and Delay]()
11. [Rotate Degree]()
12. [Shadow]()
13. [Dimensions]()
14. [Boom or Reboom It Programmatically]()
15. [Delegate]()
16. [Warnings]()

[Versions]()  
[License]()

#Pod
Use BMB by:  

1. Pod: ```pod "VHBoomMenuButton", "~> 0.0.3"``` 
2. Or copy the source code of the BMB to your project.

#Note
1. From my [BMB in Android version](https://github.com/Nightonke/BoomMenu). 
2. I'm a new guy in iOS, so if there is any bug or enhancement, just put it in issues or mail(Nightonke@outlook.com)
3. Structure of BMB:  
    ![](https://github.com/Nightonke/VHBoomMenuButton/blob/master/VHBoomMenuButtonPictures/structure.png?raw=true)  
    BMB is seperated into 3 sub-parts and 1 main part, for managing the animations, pieces on the BMB and the Boom-button on the screen. So if you wanna fork then add more boom-buttons to BMB, let's name it A, just:
    1. create a ABuilder in BoomButton extends [VHBoomButtonBuilder](https://github.com/Nightonke/VHBoomMenuButton/blob/master/VHBoomMenuButton/BoomButton/VHBoomButtonBuilder.h)
    2. create a AButton in BoomButton extends [VHBoomButton](https://github.com/Nightonke/VHBoomMenuButton/blob/master/VHBoomMenuButton/BoomButton/VHBoomButton.h)
    3. create a APiece in Piece extends [VHBoomPiece](https://github.com/Nightonke/VHBoomMenuButton/blob/master/VHBoomMenuButton/Piece/VHBoomPiece.h)
    4. add your piece-place and button-place logic in [VHPiecePlaceManager](https://github.com/Nightonke/VHBoomMenuButton/blob/master/VHBoomMenuButton/Piece/VHPiecePlaceManager.h) and [VHButtonPlaceManager](https://github.com/Nightonke/VHBoomMenuButton/blob/master/VHBoomMenuButton/BoomButton/VHButtonPlaceManager.h)

#Usage
###Basic Usage
Let's check a very simple usage with just 3 buttons.  
```
//
//  ViewController.m
//  VHBoomMenuButtonTest
//
//  Created by 黄伟平 on 16/8/7.
//  Copyright © 2016年 黄伟平. All rights reserved.
//

#import "ViewController.h"
#import "VHBoomMenuButton.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

@interface ViewController ()

@end

@implementation ViewController

- (void)loadView
{
    CGRect screenFrame         = [[UIScreen mainScreen] bounds];
    self.view                  = [[UIView alloc] initWithFrame:screenFrame];
    self.view.backgroundColor  = [UIColor whiteColor];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    // Put bmb in your VC
    CGFloat bmbRadius = 60;
    VHBoomMenuButton *bmb = [[VHBoomMenuButton alloc] initWithFrame:CGRectMake(screenFrame.size.width - 20 - bmbRadius,
                                                                               screenFrame.size.height - 20 - bmbRadius,
                                                                               bmbRadius,
                                                                               bmbRadius)];
    
    // Select the button type you want
    bmb.buttonEnum = VHSimpleCircle;
    
    // Tell BMB how to place the button on itself(before BOOM)
    bmb.piecePlaceEnum = VHPiecePlace_DOT_3_1;
    
    // Tell BMB how to place the button on screen(after BOOM)
    bmb.buttonPlaceEnum = VHButtonPlace_SC_3_3;
    
    // Add some buttons by builder
    [bmb addSimpleCircleButtonBuilderBlock:^(VHSimpleCircleButtonBuilder *builder) {
        builder.imageNormal                  = @"bat";
        builder.buttonNormalColor = UIColorFromRGB(0xD32F2F);
        builder.buttonPressedColor = UIColorFromRGB(0xF44336);
    }];
    
    [bmb addSimpleCircleButtonBuilderBlock:^(VHSimpleCircleButtonBuilder *builder) {
        builder.imageNormal                  = @"bear";
        builder.buttonNormalColor = UIColorFromRGB(0xD32F2F);
        builder.buttonPressedColor = UIColorFromRGB(0xF44336);
    }];
    
    [bmb addSimpleCircleButtonBuilderBlock:^(VHSimpleCircleButtonBuilder *builder) {
        builder.imageNormal                  = @"bee";
        builder.buttonNormalColor = UIColorFromRGB(0xD32F2F);
        builder.buttonPressedColor = UIColorFromRGB(0xF44336);
    }];
    
    [self.view addSubview:bmb];
}

@end

```

All you need to do is just select some properties then add your buttons.  

But, WARNING! You must keep ```the number of piecePlaceEnum```, ```the number of buttonPlaceEnum```, ```the number of builders you add``` to be the same. The name of piecePlaceEnum is VHPiecePlace_XXX_N_M, where XXX is name, N is number and M is different types. Similarly, the name of buttonPlaceEnum is VHButtonPlace_YYY_N_M. You must keep the first N equals to the second one. But you needn't keep the two M same. (Just like the code above: ```VHPiecePlace_DOT_3_1``` and ```VHButtonPlace_SC_3_3```)

#Boom Buttons

###Simple Circle Button
This is the most simple button type here. Set button type for your BMB: ```bmb.buttonEnum = VHSimpleCircle```

####Piece Place Type
Set piece-place type for your BMB: ```bmb.piecePlaceEnum = VHPiecePlace_DOT_3_1```. For number 1 to 9, BMB supports the following place type: (1 <= M <= number of images)   

| Number of Button | VHPiecePlaceEnum | Images |
| :-------- | :--------| :--------|
| 1  | VHPiecePlace\_DOT\_1 | ![](https://github.com/Nightonke/VHBoomMenuButton/blob/master/VHBoomMenuButtonPictures/DOT_1.png?raw=true) | 
| 2  | VHPiecePlace\_DOT\_2\_M | ![](https://github.com/Nightonke/VHBoomMenuButton/blob/master/VHBoomMenuButtonPictures/DOT_2_1.png?raw=true)![](https://github.com/Nightonke/VHBoomMenuButton/blob/master/VHBoomMenuButtonPictures/DOT_2_2.png?raw=true) | 
| 3  | VHPiecePlace\_DOT\_3\_M | ![](https://github.com/Nightonke/VHBoomMenuButton/blob/master/VHBoomMenuButtonPictures/DOT_3_1.png?raw=true)![](https://github.com/Nightonke/VHBoomMenuButton/blob/master/VHBoomMenuButtonPictures/DOT_3_2.png?raw=true) ![](https://github.com/Nightonke/VHBoomMenuButton/blob/master/VHBoomMenuButtonPictures/DOT_3_3.png?raw=true) ![](https://github.com/Nightonke/VHBoomMenuButton/blob/master/VHBoomMenuButtonPictures/DOT_3_4.png?raw=true) | 
| 4  | VHPiecePlace\_DOT\_4\_M | ![](https://github.com/Nightonke/VHBoomMenuButton/blob/master/VHBoomMenuButtonPictures/DOT_4_1.png?raw=true)![](https://github.com/Nightonke/VHBoomMenuButton/blob/master/VHBoomMenuButtonPictures/DOT_4_2.png?raw=true) | 
| 5  | VHPiecePlace\_DOT\_5\_M | ![](https://github.com/Nightonke/VHBoomMenuButton/blob/master/VHBoomMenuButtonPictures/DOT_5_1.png?raw=true)![](https://github.com/Nightonke/VHBoomMenuButton/blob/master/VHBoomMenuButtonPictures/DOT_5_2.png?raw=true) ![](https://github.com/Nightonke/VHBoomMenuButton/blob/master/VHBoomMenuButtonPictures/DOT_5_3.png?raw=true) ![](https://github.com/Nightonke/VHBoomMenuButton/blob/master/VHBoomMenuButtonPictures/DOT_5_4.png?raw=true) |

#Versions

#License

    Copyright 2016 Nightonke

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

