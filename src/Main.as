package {
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.b2Color;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Joints.b2FrictionJointDef;
	import com.bit101.components.Component;
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author William
	 */
	public class Main extends Sprite {
		private var _bot:BotActor;
		private var _runs:Array;
		private var _hitWallBlock:HitWallBlock;
		private var _actors:Array;
		private var draw:b2DebugDraw;
		private var _enemyBot:BotActor;
		private var _GUIElements:Array;
		private var _callbackBlocks:Array;
		private var _interval:int = 30;
		public var _bodiesToDestroy:Array;
		
		public function Main(name:String, rootBlocks:Array):void {
			this.name = name;
			_bodiesToDestroy = new Array();
			_GUIElements = new Array();
			this.addEventListener(Event.ENTER_FRAME, update);
			setupWorld();
			setupDebugDraw();
			setupGui();
			makeWalls();
			_bot = new BotActor(1.0, this);
			_enemyBot = new BotActor(1.0, this);
			_actors = new Array(_bot, _enemyBot);
			_runs = new Array();
			_callbackBlocks = new Array();
			for each (var rootBlock:Block in rootBlocks) {
				if (rootBlock is CallBackBlock) {
					if (rootBlock is HitWallBlock) {
						_hitWallBlock = (rootBlock as HitWallBlock);
					} else {
						_callbackBlocks.push(rootBlock);
					}
				} else {
					_runs.push(new Run(_bot, rootBlock, _interval));
				}
			}
		}
		
		private function setupGui():void {
			var pushButton:PushButton = new PushButton(this, 0, 0, "Back", goBack);
			pushButton.y = 600 - pushButton.height;
			_GUIElements.push(pushButton);
		}
		
		public function goBack(e:Event):void {
			for each (var element:Component in _GUIElements) {
				removeChild(element);
			}
			Values.draw.GetSprite().alpha = 0;
			removeEventListener(Event.ENTER_FRAME, update);
			parent.removeChild(this);
		}
		
		private function addForceToBot():void {
			_bot.Body.SetLinearVelocity(new b2Vec2(100, 30));
		}
		
		private function makeWalls():void {
			var horizWallShape:b2PolygonShape = new b2PolygonShape();
			var vertWallShape:b2PolygonShape = new b2PolygonShape();
			horizWallShape.SetAsBox(400 / Values.RATIO, 5 / Values.RATIO);
			vertWallShape.SetAsBox(5 / Values.RATIO, 300 / Values.RATIO);
			
			var fixDef:b2FixtureDef = new b2FixtureDef();
			fixDef.shape = horizWallShape;
			fixDef.density = 0.0
			
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.type = b2Body.b2_staticBody;
			bodyDef.position = new b2Vec2(400 / Values.RATIO, 0 / Values.RATIO);
			
			var topWall:b2Body = Values.world.CreateBody(bodyDef);
			topWall.CreateFixture(fixDef);
			topWall.SetUserData(this);
			
			bodyDef = new b2BodyDef();
			bodyDef.type = b2Body.b2_staticBody;
			bodyDef.position = new b2Vec2(400 / Values.RATIO, 600 / Values.RATIO);
			
			var bottomWall:b2Body = Values.world.CreateBody(bodyDef);
			bottomWall.CreateFixture(fixDef);
			bottomWall.SetUserData(this);
			
			fixDef = new b2FixtureDef();
			fixDef.shape = vertWallShape;
			fixDef.density = 0.0;
			
			bodyDef = new b2BodyDef();
			bodyDef.type = b2Body.b2_staticBody;
			bodyDef.position = new b2Vec2(0 / Values.RATIO, 300 / Values.RATIO);
			
			var leftWall:b2Body = Values.world.CreateBody(bodyDef);
			leftWall.CreateFixture(fixDef);
			leftWall.SetUserData(this);
			
			fixDef = new b2FixtureDef();
			fixDef.shape = vertWallShape;
			fixDef.density = 0.0;
			
			bodyDef = new b2BodyDef();
			bodyDef.type = b2Body.b2_staticBody;
			bodyDef.position = new b2Vec2(800 / Values.RATIO, 300 / Values.RATIO);
			
			var rightWall:b2Body = Values.world.CreateBody(bodyDef);
			rightWall.CreateFixture(fixDef);
			rightWall.SetUserData(this);
			
		}
		
		private function update(e:Event):void {
			Values.world.Step(1.0 / 60.0, 10, 10);
			Values.world.DrawDebugData();
			var finishedRuns:Array = new Array();
			for each (var actor:Actor in _actors) {
				actor.move();
			}
			//stack mode
			if (_runs[0] != null) {
				(_runs[_runs.length - 1] as Run).go();
				if ((_runs[_runs.length - 1] as Run)._isDone) {
					_runs.splice(_runs.length - 1, 1);
				}
			}
			//threaded mode
			/*for each (var r:Run in _runs) {
				r.go();
				if (r._isDone) { finishedRuns.push(r); }
			}
			for each (var f:Run in finishedRuns) {
				_runs.splice(_runs.indexOf(f), 1);
			}*/
			if (_bot.health <= 0) {
				_bot.destroy();
			}
			if (_enemyBot.health <= 0) {
				_enemyBot.destroy();
			}
			
			for each (var body:b2Body in _bodiesToDestroy) {
				Values.world.DestroyBody(body);
			}
			//updating callback blocks
			for each (var block:CallBackBlock in _callbackBlocks) {
				block.update(Values.world, _bot);
				if (block._go) {
					_runs.push(new Run(_bot, block, _interval));
				}
			}
		}
		
		private function setupDebugDraw():void {
			var sprite:Sprite = new Sprite();
			
			draw = new b2DebugDraw();
			draw.SetSprite(sprite);
			draw.SetDrawScale(Values.RATIO);
			draw.SetFlags(b2DebugDraw.e_shapeBit);
			draw.SetLineThickness(2);
			draw.SetFillAlpha(0.6);
			Values.world.SetDebugDraw(draw);
			addChild(sprite);
			Values.draw = draw
		}
		
		public function setupWorld():void {
			Values.world = new b2World(new b2Vec2(0, 0), true);
			Values.world.SetContactListener(new ContactListener());
		}
		
		public function executeCallBackBlock(type:String, bot:BotActor):void {
			if (type == "HitWallBlock") {
				_runs.push(new Run(bot, _hitWallBlock, _interval));
			}
		}
	}
	
}