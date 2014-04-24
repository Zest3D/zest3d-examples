package plugin.examples.oimo 
{
	import com.element.oimo.physics.collision.shape.BoxShape;
	import com.element.oimo.physics.collision.shape.CylinderShape;
	import com.element.oimo.physics.collision.shape.ShapeConfig;
	import com.element.oimo.physics.collision.shape.SphereShape;
	import com.element.oimo.physics.dynamics.RigidBody;
	import io.plugin.core.graphics.Color;
	import io.plugin.math.algebra.APoint;
	import io.plugin.utils.Stats;
	import plugin.examples.oimo.helpers.OimoMesh3D;
	import plugin.examples.oimo.helpers.Zest3DOimoWorld;
	import zest3d.applications.Zest3DApplication;
	import zest3d.localeffects.PhongEffect;
	import zest3d.geometry.SkyboxGeometry;
	import zest3d.primitives.CubePrimitive;
	import zest3d.primitives.CylinderPrimitive;
	import zest3d.primitives.SpherePrimitive;
	import zest3d.resources.Texture2D;
	import zest3d.resources.TextureCube;
	import zest3d.scenegraph.enum.CullingType;
	import zest3d.scenegraph.enum.LightType;
	import zest3d.scenegraph.Light;
	import zest3d.scenegraph.TriMesh;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class OimoExample extends Zest3DApplication 
	{
		
		[Embed(source="../../../assets/atfcube/skybox.atf", mimeType="application/octet-stream")]
		private var SkyboxTexture:Class;
		
		[Embed(source="../../../assets/atf/space.atf", mimeType="application/octet-stream")]
		private const SPACE_ATF:Class;
		
		private var _oimoWorld:Zest3DOimoWorld;
		
		override protected function initialize():void 
		{
			clearColor = Color.fromHexRGB( 0xFFFFFF );
			
			// set the camera position
			camera.position = new APoint( 0, -6, -25 );
			
			// add stats
			addChild( new Stats() );
			
			// set the clear color
			clearColor = new Color( 0, 0, 0, 1 );
			
			// create texture and effect
			var spaceTexture:Texture2D = Texture2D.fromByteArray( new SPACE_ATF() );
			
			var light:Light = new Light();
			light.position = new APoint( 0, -10, -80 );
			light.ambient = new Color( 0.3, 0.3, 0.3 );
			light.specular = new Color( 1, 1, 1 );
			light.exponent = 6;
			
			var spaceEffect:PhongEffect = new PhongEffect( spaceTexture, light );
			
			var skyboxTexture:TextureCube = TextureCube.fromByteArray( new SkyboxTexture() );
			
			// Oimo
			_oimoWorld = new Zest3DOimoWorld( 30 );
			
			// Add Ground
			var plane:CubePrimitive = new CubePrimitive( spaceEffect, true, true, false, false, 10, 10, 10 );
			plane.translate( 0, 10, 0 );
			plane.culling = CullingType.NEVER;
			_oimoWorld.addCube( plane, 10, 10, 10, RigidBody.BODY_STATIC );
			scene.addChild( plane );
			
			// Add Boxes
			var i:int;
			for ( i = 0; i < 100; ++i )
			{
				var cube:CubePrimitive = new CubePrimitive( spaceEffect, true, true, false, false, 1, 1, 1, false ); 
				cube.translate( (Math.random() * 10) - 5, ( -Math.random() * 1500) - 5, (Math.random() * 10) - 5 );
				scene.addChild( cube );
				_oimoWorld.addCube( cube, 1, 1, 1);
			}
			
			// Add Spheres
			for ( i = 0; i < 100; ++i )
			{
				var sphere:SpherePrimitive = new SpherePrimitive( spaceEffect, true, true, false, false, 16, 16, 1, false, false );
				sphere.translate( (Math.random() * 10) - 5, ( -Math.random() * 1500) - 5, (Math.random() * 10) - 5 );
				scene.addChild( sphere );
				_oimoWorld.addSphere( sphere, 1 );
			}
			
			// Add Cylinders
			for ( i = 0; i < 100; ++i )
			{
				var cylinder:CylinderPrimitive = new CylinderPrimitive( spaceEffect, true, true, false, false, 4, 16, 1, 2, false, false, false );
				cylinder.translate( (Math.random() * 10) - 5, ( -Math.random() * 1500) - 5, (Math.random() * 10) - 5 );
				scene.addChild( cylinder );
				_oimoWorld.addCylinder( cylinder, 1, 2 );
			}
			
			skybox = new SkyboxGeometry( skyboxTexture );
		}
		
		override protected function update(appTime:Number):void 
		{
			_oimoWorld.step();
		}
		
	}
}