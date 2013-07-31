package  
{
	import Box2D.Dynamics.b2Body;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	import flash.events.EventPhase;
	/**
	 * ...
	 * @author William
	 */
	public class Actor extends EventDispatcher
	{
		private var _Body:b2Body;
		private var _Graphic:DisplayObject;
		private var _needsCentering:Boolean;
		private var _parent:DisplayObjectContainer;
		public function Actor(body:b2Body, graphic:DisplayObject, needsCentering:Boolean, parent:DisplayObjectContainer) {
			_Body = body;
			_Body.SetUserData(this);
			_Graphic = graphic;
			_needsCentering = needsCentering;
			_parent = parent;
			move();
		}
		
		public function move():void {
			if (_Graphic != null) {
				if (_needsCentering) {
					_Graphic.x = (_Body.GetPosition().x * Values.RATIO) - (_Graphic.height / 2);
					_Graphic.y = (_Body.GetPosition().y * Values.RATIO) - (_Graphic.width / 2);
				} else {
					_Graphic.x = (_Body.GetPosition().x * Values.RATIO)
					_Graphic.y = (_Body.GetPosition().y * Values.RATIO)
				}
				_Graphic.rotation = _Body.GetAngle() * 180 / Math.PI;
			}
			update();
		}
		
		protected function update():void {
			
		}
		
		public function destroy():void {
			onDestroy();
			Values.world.DestroyBody(_Body);
			trace(_Body);
			if (_Graphic != null) {
				_Graphic.parent.removeChild(_Graphic);
			}
		}
		
		protected function onDestroy():void {
			
		}
		
		public function get Body():b2Body 
		{
			return _Body;
		}
		
		public function set Body(value:b2Body):void 
		{
			_Body = value;
		}
		
		public function get Graphic():DisplayObject 
		{
			return _Graphic;
		}
		
		public function set Graphic(value:DisplayObject):void 
		{
			_Graphic = value;
			
		}
		
		public function get parent():DisplayObjectContainer 
		{
			return _parent;
		}
		
		public function set parent(value:DisplayObjectContainer):void 
		{
			_parent = value;
		}
	}
}