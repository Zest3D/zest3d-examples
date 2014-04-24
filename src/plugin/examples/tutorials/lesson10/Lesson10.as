package plugin.examples.tutorials.lesson10 
{
	import com.element.oimo.physics.dynamics.RigidBody;
	import io.plugin.core.graphics.Color;
	import io.plugin.math.algebra.APoint;
	import plugin.examples.oimo.helpers.Zest3DOimoWorld;
	import zest3d.applications.Zest3DApplication;
	import zest3d.localeffects.PhongEffect;
	import zest3d.geometry.SkyboxGeometry;
	import zest3d.primitives.CubePrimitive;
	import zest3d.primitives.CylinderPrimitive;
	import zest3d.resources.Texture2D;
	import zest3d.resources.TextureCube;
	import zest3d.scenegraph.enum.CullingType;
	import zest3d.scenegraph.Light;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class Lesson10 extends Zest3DApplication 
	{
		
		[Embed(source="../../../../assets/atfcube/skybox.atf", mimeType="application/octet-stream")]
		private var SKYBOX_ATF:Class;
		
		[Embed(source="../../../../assets/atf/space.atf", mimeType="application/octet-stream")]
		private const SPACE_ATF:Class;
		
		private var _oimoWorld:Zest3DOimoWorld;
		override protected function initialize():void 
		{
			camera.position = new APoint( 0, -6, -30 );
			
			var spaceTexture:Texture2D = Texture2D.fromByteArray( new SPACE_ATF() );
			
			var light:Light = new Light();
			light.position = new APoint( 0, -10, -80 );
			light.ambient = new Color( 0.3, 0.3, 0.3 );
			light.specular = new Color( 1, 1, 1 );
			light.exponent = 6;
			
			var spaceEffect:PhongEffect = new PhongEffect( spaceTexture, light );
			
			skybox = new SkyboxGeometry( TextureCube.fromByteArray( new SKYBOX_ATF() ));
			
			_oimoWorld = new Zest3DOimoWorld(30);
			
			var ground:CubePrimitive = new CubePrimitive(spaceEffect, true, true, false, false, 10, 10, 10);
			ground.translate(0, 10, 0);
			ground.culling = CullingType.NEVER;
			scene.addChild(ground);
			_oimoWorld.addCube(ground, 10, 10, 10, RigidBody.BODY_STATIC);
			
			
			// Add Cylinders
			for ( var i:int = 0; i < 100; ++i )
			{
				var cylinder:CylinderPrimitive = new CylinderPrimitive(spaceEffect);
				cylinder.translate( (Math.random() * 10) - 5, ( -Math.random() * 1500) - 5, (Math.random() * 10) - 5 );
				scene.addChild( cylinder );
				_oimoWorld.addCylinder( cylinder, 1, 2 );
			}
			
		}
		
		override protected function update(appTime:Number):void 
		{
			_oimoWorld.step();
		}
	}

}