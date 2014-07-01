package plugin.examples.bullet 
{
	import flash.events.MouseEvent;
	import io.plugin.math.algebra.APoint;
	import io.plugin.math.algebra.AVector;
	import zest3d.applications.Zest3DApplication;
	import zest3d.ext.bullet.collision.shapes.BulletBoxShape;
	import zest3d.ext.bullet.dynamics.BulletDynamicsWorld;
	import zest3d.ext.bullet.dynamics.BulletRigidBody;
	import zest3d.localeffects.TextureEffect;
	import zest3d.primitives.CubePrimitive;
	import zest3d.resources.Texture2D;
	import zest3d.scenegraph.enum.CullingType;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class BulletPhysicsExample extends Zest3DApplication 
	{
		
		[Embed(source = "../../../assets/atf/bw_checked.atf", mimeType = "application/octet-stream")]
		private const BW_CHECKED_ATF:Class;
		
		private var bwCheckedTexture:Texture2D;
		private var effect:TextureEffect;
		private var world:BulletDynamicsWorld;
		private var floorMesh:CubePrimitive;
		private var floorShape:BulletBoxShape;
		private var floorRigidBody:BulletRigidBody;
		
		override protected function initialize():void 
		{
			camera.position = new APoint( 0, -200, -400 );
			camera.setFrustumFOV( 80, stage.stageWidth / stage.stageHeight, 0.1, 2000 );
			
			bwCheckedTexture = Texture2D.fromByteArray( new BW_CHECKED_ATF() );
			effect = new TextureEffect(bwCheckedTexture);
			
			world = BulletDynamicsWorld.getInstance();
			world.initWithDbvtBroadphase();
			
			floorMesh = new CubePrimitive(effect, true, false, false, false );
			floorMesh.scale( 500, 5, 500 );
			floorMesh.culling = CullingType.NEVER;
			floorShape = new BulletBoxShape(100000, 1000, 100000);
			
			floorRigidBody = new BulletRigidBody(floorShape, floorMesh, 0);
			floorRigidBody.position = new AVector( 0, 0, 0 );
			world.addRigidBody(floorRigidBody);
			
			scene.addChild( floorMesh );
		}
		
		override protected function update(appTime:Number):void 
		{
			world.step(1 / 30, 1, 1 / 30);
		}
		
		override protected function onMouseDown(e:MouseEvent):Boolean 
		{
			var cubeMesh:CubePrimitive = new CubePrimitive(effect, true, false, false, false, 50, 50, 50);
			scene.addChild(cubeMesh);
			
			var cubeShape:BulletBoxShape = new BulletBoxShape(10000, 10000, 10000);
			var cubeRigidBody:BulletRigidBody = new BulletRigidBody(cubeShape, cubeMesh, 1);
			world.addRigidBody(cubeRigidBody);
			cubeRigidBody.friction = 1;
			cubeRigidBody.position = new AVector(Math.random() * 6000 - 3000, Math.random() * -60000 , Math.random() * 6000 - 3000);
			
			return super.onMouseDown(e);
		}
	}

}