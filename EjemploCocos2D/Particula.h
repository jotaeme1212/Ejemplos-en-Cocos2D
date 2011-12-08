//
//  Particula.h
//  EjemploCocos2D
//
//  Created by Juan Manuel Marchese on 02-11-11.
//  Copyright JMM 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import <Foundation/Foundation.h>
#import "cocos2d.h"

// Particula
@interface Particula : CCLayer {

    CCParticleMeteor *emisor; // Emisor de efecto.
    CCSprite *homeButton;

}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
