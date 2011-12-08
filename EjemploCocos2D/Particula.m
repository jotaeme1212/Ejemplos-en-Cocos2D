//
//  Particula.m
//  EjemploCocos2D
//
//  Created by Juan Manuel Marchese on 02-11-11.
//  Copyright JMM 2011. All rights reserved.
//

// Import the interfaces
#import "Particula.h"
#import "HelloWorldLayer.h"

// HelloWorldLayer implementation
@implementation Particula

+(CCScene *) scene {

	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Particula *layer = [Particula node];
	
	// add layer as a child to scene
	[scene addChild: layer];

    CCSprite *background = [CCSprite spriteWithFile:@"fondo1.png"];
	background.anchorPoint = ccp(0,0);    
    [layer addChild:background z:-1];

	// return the scene
	return scene;

} // Fin scene

// on "init" you need to initialize your instance
-(id) init {

	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if((self = [super init])) {

        /*
        Código por defecto que muestra el Hola Mundo de la plantilla original.
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:64];
		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height/2 );
		// add the label as a child to this Layer
		[self addChild: label];
        */

        // Emisor de efecto.
        self.isTouchEnabled = YES;
        emisor = [[CCParticleMeteor alloc] init];
        emisor.texture = [[CCTextureCache sharedTextureCache] addImage:@"Particula.png"];
        emisor.position = ccp(240,160);
        [self addChild:emisor];

        // Botón para volver al menú
        homeButton = [CCSprite spriteWithFile:@"home.png"];
        homeButton.anchorPoint = ccp(0.5,0.5);
        homeButton.position = ccp(30,450);
        [self addChild:homeButton];

	}
	return self;

} // Fin init

// Método para cuando los Touchs empiezan.
- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    // Primero ubicamos el punto (point) de la ubicación (location) de nuestro toque (touch).
    UITouch *myTouch = [touches anyObject];
    CGPoint location = [myTouch locationInView:[myTouch view]];
    CGPoint point = [[CCDirector sharedDirector] convertToGL:location];

    // Le damos a nuestro emisor, el punto del toque.
    emisor.position = ccp(point.x, point.y);

} // Fin ccTouchesBegan


// Método para cuando los Touchs se mueven.
- (void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

    UITouch *myTouch = [touches anyObject];
    CGPoint location = [myTouch locationInView:[myTouch view]];
    CGPoint point = [[CCDirector sharedDirector] convertToGL:location];
    emisor.position = ccp(point.x, point.y);

} // Fin ccTouchesMoved

// Método para cuando los Touchs finalizan (se levante el dedo de la pantalla).
- (void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    UITouch *myTouch = [touches anyObject];
    CGPoint location = [myTouch locationInView:[myTouch view]];
    CGPoint point = [[CCDirector sharedDirector] convertToGL:location];

    // Esto para detectar el toque que sea en una posicion aproximada, cercana a la del botón.
    float distance = powf(point.x - homeButton.position.x, 2) + powf(point.y - homeButton.position.y, 2);
    distance = sqrtf(distance);
    if (distance <= 20) {
        // Se vuelve a la ventana inicial
        [[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:2 scene:[HelloWorldLayer node]]];
    }

} // Fin ccTouchesEnded

// on "dealloc" you need to release all your retained objects
- (void) dealloc {
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
    emisor = nil;
    [emisor release];
}

@end
