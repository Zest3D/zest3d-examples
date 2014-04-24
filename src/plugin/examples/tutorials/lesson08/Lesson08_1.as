package plugin.examples.tutorials.lesson08 
{
	import io.plugin.core.graphics.Color;
	import io.plugin.math.algebra.APoint;
	import io.plugin.math.algebra.AVector;
	import io.plugin.math.algebra.HMatrix;
	import io.plugin.math.algebra.HQuaternion;
	import zest3d.applications.Zest3DApplication;
	import zest3d.controllers.enum.RepeatType;
	import zest3d.controllers.KeyframeController;
	import zest3d.datatypes.Transform;
	import zest3d.localeffects.PhongEffect;
	import zest3d.geometry.SkyboxGeometry;
	import zest3d.primitives.TorusPrimitive;
	import zest3d.resources.Texture2D;
	import zest3d.resources.TextureCube;
	import zest3d.scenegraph.Light;
	import zest3d.scenegraph.LightNode;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class Lesson08_1 extends Zest3DApplication 
	{
		[Embed(source = "../../../../assets/atf/crate_wood.atf", mimeType = "application/octet-stream")]
		private const CHECKED_ATF:Class;
		
		[Embed(source = "../../../../assets/atfcube/skybox.atf", mimeType = "application/octet-stream")]
		private const SKYBOX_ATF:Class;
		
		private var _keyframeController:KeyframeController;
		override protected function initialize():void 
		{
			skybox = new SkyboxGeometry( TextureCube.fromByteArray( new SKYBOX_ATF() ) );
			var checkedTexture:Texture2D = Texture2D.fromByteArray( new CHECKED_ATF() );
			
			var light:Light = new Light();
			light.ambient = new Color( 0.2, 0.2, 0.2 );
			light.specular = new Color( 0.7, 0.7, 0.7 );
			
			light.exponent = 10;
			
			var lightNode:LightNode = new LightNode( light );
			lightNode.translate( -10, -5, -2 );
			scene.addChild( lightNode );
			
			var phongEffect:PhongEffect = new PhongEffect(checkedTexture, light);
			
			var torus:TorusPrimitive = new TorusPrimitive(phongEffect, true, true, false, false, 64, 32);
			
			_keyframeController = new KeyframeController( 0, 3, 4, 4, new Transform() );
			_keyframeController.minTime = 0;
			_keyframeController.maxTime = 9000;
			_keyframeController.repeat = RepeatType.WRAP;
			
			// rotations
			var m0:HMatrix = new HMatrix().rotation( AVector.UNIT_Z, (Math.PI / 180) * 90);
			var m1:HMatrix = new HMatrix().rotation( AVector.UNIT_Y, (Math.PI / 180) * 180);
			var m2:HMatrix = new HMatrix().rotation( AVector.UNIT_X, (Math.PI / 180) * 180);
			var m3:HMatrix = new HMatrix().rotation( AVector.UNIT_Y, (Math.PI / 180) * 90);
			_keyframeController.rotations[0] = HQuaternion.fromRotationMatrix( m0 );
			_keyframeController.rotations[1] = HQuaternion.fromRotationMatrix( m1 );
			_keyframeController.rotations[2] = HQuaternion.fromRotationMatrix( m2 );
			_keyframeController.rotations[3] = HQuaternion.fromRotationMatrix( m3 );
			_keyframeController.rotationTimes[0] = 0;
			_keyframeController.rotationTimes[1] = 3000;
			_keyframeController.rotationTimes[2] = 6000;
			_keyframeController.rotationTimes[3] = 9000;
			
			// scales
			_keyframeController.scales[0] = 0.5;
			_keyframeController.scales[1] = 0.1;
			_keyframeController.scales[2] = 2;
			_keyframeController.scales[3] = 1;
			_keyframeController.scaleTimes[0] = 0;
			_keyframeController.scaleTimes[1] = 3000;
			_keyframeController.scaleTimes[2] = 6000;
			_keyframeController.scaleTimes[3] = 9000;
			
			//translations
			_keyframeController.translations[0] = new APoint( -5, -2, 0 );
			_keyframeController.translations[1] = new APoint(  2, -2, 0 );
			_keyframeController.translations[2] = new APoint(  2,  2, 2 );
			_keyframeController.translationTimes[0] = 0;
			_keyframeController.translationTimes[1] = 4500;
			_keyframeController.translationTimes[2] = 9000;
			
			torus.addController( _keyframeController );
			
			scene.addChild(torus);
		}
		
	}

}