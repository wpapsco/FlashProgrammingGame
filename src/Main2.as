package  
{
	import com.bit101.components.ComboBox;
	import com.bit101.components.PushButton;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	/**
	 * ...
	 * @author William
	 */
	public class Main2 extends Sprite{
		
		private var _blockButtons:Array;
		private var _Blocks:Array;
		private var _currentButton:PushButton;
		public var _backgroundSprite:Sprite;
		private var _selectedBlock:Block;
		private var _selectedBlockIndex:int;
		private var _isRunning:Boolean;
		private var _callBackBlocks:Array;
		private var _startBlock:StartBlock;
		
		public function Main2() {
			_isRunning = false;
			_blockButtons = new Array();
			_Blocks = new Array();
			_callBackBlocks = new Array();
			_selectedBlockIndex = -1;
			setupGui();
			setupBackground();
			addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(MouseEvent.CLICK, click);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		}
		
		private function keyDown(e:KeyboardEvent):void {
			if (e.keyCode == 13) {
				var arr:Array = new Array();
				for each (var block:Block in _callBackBlocks) {
					arr.push(block);
				}
				if (_startBlock != null) {
					arr.push(_startBlock);
				}
				if (getChildByName("Main-1") == null) {
					addChild(new Main("Main-1", arr));
				}
			}
			if (e.keyCode == 46 || e.keyCode == 8) {
				if (_selectedBlockIndex > -1) {
					(_Blocks[_selectedBlockIndex] as Block).destroy();
					if (_Blocks[_selectedBlockIndex] is StartBlock) {
						_startBlock = null;
					}
					_Blocks.splice(_selectedBlockIndex, 1);
					_selectedBlockIndex = -1;
				}
			}
		}
		
		private function click(e:MouseEvent):void {
			if (e.target == stage) {
				if (_selectedBlockIndex > -1) {
					(_Blocks[_selectedBlockIndex] as Block)._selectButton.enabled = true;
				}
				_selectedBlockIndex = -1;
			}
		}
		
		private function setupBackground():void {
			_backgroundSprite = new Sprite();
			addChild(_backgroundSprite);
			_backgroundSprite.graphics.lineStyle(5, 0x0000FF, 1);
		}
		
		public static function drawArrow(start:Point, endPoint:Point, parent:DisplayObjectContainer, color:uint = 0x000000, thickness:Number = 1):Sprite {
			var sprite:Sprite = new Sprite();
			parent.addChild(sprite);
			sprite.graphics.lineStyle(thickness, color)
			
			var angle:Number = Main2.pointsToAngle(start.x, start.y, endPoint.x, endPoint.y) - 270;
			
			var midPoint:Point = new Point((start.x + endPoint.x) / 2, (start.y + endPoint.y) / 2);
			angle = angle - 45;
			if (angle < 0) {
				angle+=360;
			}
			var xval:Number = (.25 * (Math.cos(angle * Math.PI / 180) * 180 / Math.PI) + midPoint.x);
			var yval:Number = (.25 * (Math.sin(angle * Math.PI / 180) * 180 / Math.PI) + midPoint.y);
			
			sprite.graphics.moveTo(midPoint.x, midPoint.y);
			sprite.graphics.lineTo(xval, yval);
			
			angle = angle + 90;
			if (angle > 360) {
				angle-=360;
			}
			xval = (.25 * (Math.cos(angle * Math.PI / 180) * 180 / Math.PI) + midPoint.x);
			yval = (.25 * (Math.sin(angle * Math.PI / 180) * 180 / Math.PI) + midPoint.y);
			
			sprite.graphics.moveTo(midPoint.x, midPoint.y);
			sprite.graphics.lineTo(xval, yval);
			sprite.graphics.moveTo(start.x, start.y);
			sprite.graphics.lineTo(endPoint.x, endPoint.y);
			
			return sprite;
		}
		
		private function update(e:Event):void {
			if (_currentButton != null) {
				_currentButton.move(mouseX - (_currentButton.width / 2), mouseY - (_currentButton.height / 2));
			}
		}
		
		private function setupGui():void {
			var names:Array = new Array(
				"Start",
				"Aim at an enemy",
				"Move forward",
				"Strafe",
				"Rotate",
				"Shoot", //callbackblocks start here
				"Hit wall", 
				"Health below"
			);
			var yInt:int = 20;
			for (var i:int = 0; i < names.length; i++) {
				_blockButtons.push(new PushButton(this, 0, yInt * i, names[i], blockButtonHandler));
				(_blockButtons[i] as PushButton).tag = i;
			}
		}
		
		private function blockButtonHandler(e:Event):void {
			var currentBlock:int = (e.target as PushButton).tag;
			_currentButton = new PushButton(this, mouseX, mouseY, (e.target as PushButton).label, placeButton);
			_currentButton.tag = currentBlock;
		}
		
		private function placeButton(e:Event):void {
			var button:PushButton = (e.target as PushButton);
			var x:Number = button.x;
			var y:Number = button.y;
			if (button.x > _blockButtons[0].width) {
				var tag:int = _currentButton.tag;
				if (tag == 0) {
					if (_startBlock == null) {
						_startBlock = new StartBlock(this, new Point(x, y));
						_Blocks.push(_startBlock);
					}
				} else if (tag == 1) {
					_Blocks.push(new AimAtEnemyBlock(this, new Point(x, y)));
				} else if (tag == 2) {
					_Blocks.push(new MoveForwardBlock(this, new Point(x, y)));
				} else if (tag == 3) {
					_Blocks.push(new StrafeBlock(this, new Point(x, y)));
				} else if (tag == 4) {
					_Blocks.push(new RotateBotBlock(this, new Point(x, y)));
				} else if (tag == 5) {
					_Blocks.push(new ShootBlock(this, new Point(x, y)));
				} else if (tag == 6) {
					_Blocks.push(new HitWallBlock(this, new Point(x, y)));
					_callBackBlocks.push(_Blocks[_Blocks.length - 1]);
				} else if (tag == 7) {
					_Blocks.push(new HealthBelowBlock(this, new Point(x, y)));
					_callBackBlocks.push(_Blocks[_Blocks.length - 1]);
				}
				removeChild(_currentButton);
				_currentButton = null;
			}
		}
		
		public static function pointsToAngle(s_x:Number, s_y:Number, x:Number, y:Number):Number {
			var t_imgFloatPoint:Point = new Point(x, s_y);
			if (x >= s_x && y >= s_y) {
				return (90 + (Math.asin(Point.distance(new Point(x, y), t_imgFloatPoint) / Point.distance(new Point(s_x, s_y), new Point(x, y))) * (180 / Math.PI)));
			}
			if (x >= s_x && y < s_y) {
				return ( 90 - (Math.asin(Point.distance(new Point(x, y), t_imgFloatPoint) / Point.distance(new Point(s_x, s_y), new Point(x, y))) * (180 / Math.PI)));
			}
			if (x < s_x && y < s_y) {
				return  ( 270 + (Math.asin(Point.distance(new Point(x, y), t_imgFloatPoint) / Point.distance(new Point(s_x, s_y), new Point(x, y))) * (180 / Math.PI)));
			}
			if (x < s_x && y >= s_y) {
				return  ( 270 - (Math.asin(Point.distance(new Point(x, y), t_imgFloatPoint) / Point.distance(new Point(s_x, s_y), new Point(x, y))) * (180 / Math.PI)));
			}
			return 0;
		}
		
		public function blockSelected(block:Block):void {
			if (_selectedBlockIndex == -1) {
				_selectedBlockIndex = _Blocks.indexOf(block);
				(_Blocks[_selectedBlockIndex] as Block)._selectButton.enabled = false;
			} else {
				_Blocks[_selectedBlockIndex].tryAttach(block);
				(_Blocks[_selectedBlockIndex] as Block)._selectButton.enabled = true;
				_selectedBlockIndex = -1;
			}
		}
	}

}