package plugin.screens.screen02 
{
	import io.plugin.core.graphics.Color;
	import io.plugin.math.algebra.APoint;
	import zest3d.applications.Zest3DApplication;
	import zest3d.localeffects.PhongEffect;
	import zest3d.localeffects.TextureEffect;
	import zest3d.geometry.SkyboxGeometry;
	import zest3d.primitives.TorusPrimitive;
	import zest3d.resources.Texture2D;
	import zest3d.resources.TextureCube;
	import zest3d.scenegraph.Light;
	
	/**
	 * @author Gary Paluk
	 */
	public class Screen02 extends Zest3DApplication 
	{
		
		[Embed(source = "../../../assets/atfcube/lagoon.atf", mimeType="application/octet-stream")]
		private const SKYBOX_ATF:Class;
		
		[Embed(source = "../../../assets/atf/bw_checked.atf", mimeType = "application/octet-stream")]
		private const CHECKED_ATF:Class;
		
		override protected function initialize():void 
		{
			var skyTexture:TextureCube = TextureCube.fromByteArray( new SKYBOX_ATF() );
			var checkedTexture:Texture2D = Texture2D.fromByteArray( new CHECKED_ATF() );
			
			var textureEffect:TextureEffect = new TextureEffect( checkedTexture );
			
			skybox = new SkyboxGeometry( skyTexture );
			
			var light:Light = new Light();
			light.position = new APoint( -3, -10, -5 );
			light.ambient = new Color( 0.1, 0.1, 0.3 );
			light.specular = new Color( 0.5, 0.5, 0.8 );
			light.exponent = 10;
			
			var phongEffect:PhongEffect = new PhongEffect( checkedTexture, light );
			
			var t0:TorusPrimitive = new TorusPrimitive( phongEffect, true, true, false, false, 128, 64 );
			var t1:TorusPrimitive = new TorusPrimitive( phongEffect, true, true, false, false, 6, 7 );
			var t2:TorusPrimitive = new TorusPrimitive( phongEffect, true, true, false, false, 5, 6 );
			var t3:TorusPrimitive = new TorusPrimitive( phongEffect, true, true, false, false, 4, 5 );
			var t4:TorusPrimitive = new TorusPrimitive( phongEffect, true, true, false, false, 3, 4 );
			
			t0.scaleUniform = 0.6;
			t1.scaleUniform = 0.6;
			t2.scaleUniform = 0.6;
			t3.scaleUniform = 0.6;
			t4.scaleUniform = 0.6;
			
			t0.x = 4;
			t1.x = 2;
			t2.x = 0;
			t3.x = -2;
			t4.x = -4;
			
			scene.addChild( t0 );
			scene.addChild( t1 );
			scene.addChild( t2 );
			scene.addChild( t3 );
			scene.addChild( t4 );
		}
	}
}