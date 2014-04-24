package plugin.examples.effects 
{
	import io.plugin.core.graphics.Color;
	import io.plugin.math.algebra.APoint;
	import io.plugin.utils.Stats;
	import zest3d.applications.Zest3DApplication;
	import zest3d.localeffects.PhongEffect;
	import zest3d.primitives.TorusPrimitive;
	import zest3d.resources.Texture2D;
	import zest3d.scenegraph.Light;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class PhongEffectExample extends Zest3DApplication 
	{
		
		[Embed(source = "../../../assets/atf/bw_checked.atf", mimeType = "application/octet-stream")]
		private const CHECKED_ATF:Class;
		
		private var _torus:TorusPrimitive;
		
		override protected function initialize():void 
		{
			addChild( new Stats() );
			camera.position = new APoint( 0, 0, -3 );
			clearColor = Color.fromHexRGB( 0x000000 );
			var checkedTexture:Texture2D = Texture2D.fromByteArray( new CHECKED_ATF() );
			
			var light:Light = new Light();
			light.position = new APoint( 0, -8, -20 );
			light.ambient = new Color( 0.2, 0.2, 0.2 );
			light.specular = new Color( 1, 1, 1 );
			light.exponent = 10;
			
			var effect:PhongEffect = new PhongEffect( checkedTexture, light );
			
			_torus = new TorusPrimitive( effect, true, true, false, false, 128, 64 );
			scene.addChild( _torus );
		}
		
		override protected function update(appTime:Number):void 
		{
			_torus.rotationY = appTime * 0.001;
		}
	}
}