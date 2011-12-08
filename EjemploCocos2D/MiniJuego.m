//
//  MiniJuego.m
//  EjemploCocos2D
//
//  Created by Juan Manuel Marchese on 08-12-11.
//  Copyright 2011 JMM. All rights reserved.
//

#import "MiniJuego.h"
#import "HelloWorldLayer.h"

@implementation MiniJuego

+(CCScene *) scene {

	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];

	// 'layer' is an autorelease object.
	MiniJuego *layer = [MiniJuego node];

	// add layer as a child to scene
	[scene addChild: layer];

	// return the scene
	return scene;
    
} // Fin scene

-(void) returnMenu {
    [[CCDirector sharedDirector]replaceScene:[CCTransitionRadialCCW transitionWithDuration:2 scene:[HelloWorldLayer node]]];
} // Fin returnMenu

// Se mueve a una posición X,Y aleatoria de la pantalla.
-(void) moverRandom {

    float x = arc4random()%320;
    float y = arc4random()%480;

    id mover = [CCMoveTo actionWithDuration:2 position:ccp(x, y)];
    id velMover = [CCEaseInOut actionWithAction:mover rate:3];
    [person runAction:velMover];

} // Fin moverRandom

// on "init" you need to initialize your instance
-(id) init {
    
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if((self = [super init])) {

        self.isTouchEnabled = YES; // Para poder interactuar en la escena.

        // El botón para regresar se hace haciendo un menú de imagen.
        CCMenuItemImage *home = [CCMenuItemImage itemFromNormalImage:@"home.png" selectedImage:@"home.png" target:self selector:@selector(returnMenu)];
        // Arma el menú a partir de cada uno de los items creados antes.
        CCMenu *menu = [CCMenu menuWithItems:home, nil];
        menu.position = ccp(30, 450);
        [self addChild:menu];

        // Definimos un Sprite con un personaje de la aplicación y ubicamos al personaje en el centro.
        person = [CCSprite spriteWithFile:@"personaje.png"];
        person.anchorPoint = ccp(0.5, 0.5);
        person.position = ccp(160, 240);
        [self addChild:person];

        /* No ejecutamos acciones predefinidas
        // Acciones al personaje. Se definen primero las acciones, luego se asocian al personaje (individual o en secuencia).
        id moverUno = [CCMoveTo actionWithDuration:2 position:ccp(100, 300)];
        id moverDos = [CCMoveTo actionWithDuration:1 position:ccp(200, 50)];
        id rotar360 = [CCRotateBy actionWithDuration:1 angle:360];
        id accPredef = [CCCallFunc actionWithTarget:self selector:@selector(moverRandom)]; // Acción definida en método.

        // Ejecuta solamente una acción: [person runAction:moverHacia];
        [person runAction:[CCSequence actions:moverUno, rotar360, moverDos, accPredef, nil]]; // Secuencia de acciones.
        No ejecutamos acciones predefinidas */

        [self schedule:@selector(moverRandom) interval:2]; // Se ejecuta la acción cada un intervalo.
        
	}

	return self;

} // Fin init

// Método para cuando los Touchs empiezan (Touch alrededor, cerca del personaje, para eso se usa distancia).
- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *myTouch = [touches anyObject];
    CGPoint location = [myTouch locationInView:[myTouch view]];
    CGPoint point = [[CCDirector sharedDirector] convertToGL:location];

    // Esto para detectar el toque que sea en una posicion aproximada, cercana a la del personaje.
    float distance = powf(point.x - person.position.x, 2) + powf(point.y - person.position.y, 2);
    distance = sqrtf(distance);
    if (distance <= 20) {

        [self stopAllActions];
        [self unschedule:@selector(moverRandom)];
        id saltar = [CCJumpTo actionWithDuration:1 position:ccp(person.position.x + 20, person.position.y) height:80 jumps:3];
        [person runAction:saltar];

    }
    
} // Fin ccTouchesBegan

@end
