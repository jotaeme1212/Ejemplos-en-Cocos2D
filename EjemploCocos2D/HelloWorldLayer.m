//
//  HelloWorldLayer.m
//  EjemploCocos2D
//
//  Created by Juan Manuel Marchese on 02-11-11.
//  Copyright JMM 2011. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

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
        
	}
	return self;

}

// Método para cuando los Touchs empiezan.
- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    // Primero ubicamos el punto (point) de la ubicación (location) de nuestro toque (touch).
    CGPoint location = [touch locationInView:[touch view]];
    CGPoint point = [[CCDirector sharedDirector] convertToGL:location];
    // Le damos a nuestro emisor, el punto del toque.
    emisor.position = ccp(point.x, point.y);
    return YES;
}

// Método para cuando los Touchs se mueven.
- (void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *myTouch = [touches anyObject];
    CGPoint location = [myTouch locationInView:[myTouch view]];
    CGPoint point = [[CCDirector sharedDirector] convertToGL:location];
    emisor.position = ccp(point.x, point.y);
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
