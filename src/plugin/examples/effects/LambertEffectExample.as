package plugin.examples.effects 
{
	import io.plugin.core.graphics.Color;
	import io.plugin.math.algebra.APoint;
	import io.plugin.utils.Stats;
	import zest3d.applications.Zest3DApplication;
	import zest3d.localeffects.LambertEffect;
	import zest3d.primitives.TorusPrimitive;
	import zest3d.resources.Texture2D;
	import zest3d.scenegraph.enum.LightType;
	import zest3d.scenegraph.Light;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class LambertEffectExample extends Zest3DApplication 
	{
		[Embed(source="../../../assets/atf/bw_checked.atf", mimeType="application/octet-stream")]
		private const CHECKED_ATD:Class;
		
		private var _torus:TorusPrimitive;
		override protected function initialize():void 
		{
			addChild( new Stats() );
			clearColor = new Color( .8, .2, .3 );
			
			var checkedTexture:Texture2D = Texture2D.fromByteArray( new CHECKED_ATD() );
			
			var light:Light = new Light();
			light.position = new APoint( 10, 0, -10 );
			light.ambient = new Color( 0.1, 0.2, 0.3 );
			
			var effect:LambertEffect = new LambertEffect( checkedTexture, light );
			
			_torus = new TorusPrimitive( effect, true, true );
			
			scene.addChild( _torus );
		}
		
		override protected function update(appTime:Number):void 
		{
			_torus.rotationY += 0.01;
		}
	}

}