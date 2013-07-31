package  {
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	/**
	 * ...
	 * @author William
	 */
	public class ContactListener extends b2ContactListener {
		
		public function ContactListener() {
			
		}
		override public function BeginContact(contact:b2Contact):void {
			//wall contact
			if (contact.GetFixtureA().GetBody().GetUserData() is Main && contact.GetFixtureB().GetBody().GetUserData() is BotActor) {
				(contact.GetFixtureA().GetBody().GetUserData() as Main).executeCallBackBlock("HitWallBlock", contact.GetFixtureB().GetBody().GetUserData());
			}
			if (contact.GetFixtureB().GetBody().GetUserData() is Main && contact.GetFixtureA().GetBody().GetUserData() is BotActor) {
				(contact.GetFixtureB().GetBody().GetUserData() as Main).executeCallBackBlock("HitWallBlock", contact.GetFixtureA().GetBody().GetUserData());
			}
			
			//bot contact
			if (contact.GetFixtureA().GetBody().GetUserData() is BotActor && contact.GetFixtureB().GetBody().GetUserData() is BotActor) {
				(contact.GetFixtureA().GetBody().GetUserData() as BotActor).takeDamage(contact.GetFixtureB().GetBody());
				(contact.GetFixtureB().GetBody().GetUserData() as BotActor).takeDamage(contact.GetFixtureB().GetBody());
			}
			
			//bullet contact
			if (contact.GetFixtureA().GetBody().GetUserData() is BulletActor) {
				if (contact.GetFixtureB().GetBody().GetUserData() is BotActor) {
					(contact.GetFixtureB().GetBody().GetUserData() as BotActor).takeDamage(contact.GetFixtureA().GetBody());
				} else {
					((contact.GetFixtureA().GetBody().GetUserData() as BulletActor).parent as Main)._bodiesToDestroy.push(contact.GetFixtureA().GetBody());
				}
			}
			if (contact.GetFixtureB().GetBody().GetUserData() is BulletActor) {
				if (contact.GetFixtureA().GetBody().GetUserData() is BotActor) {
					(contact.GetFixtureA().GetBody().GetUserData() as BotActor).takeDamage(contact.GetFixtureB().GetBody());
				} else {
					((contact.GetFixtureB().GetBody().GetUserData() as BulletActor).parent as Main)._bodiesToDestroy.push(contact.GetFixtureB().GetBody());
				}
			}
			super.BeginContact(contact);
		}
	}

}