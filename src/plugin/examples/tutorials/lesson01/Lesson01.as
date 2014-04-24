package plugin.examples.tutorials.lesson01 
{
	import io.plugin.core.interfaces.IDisposable;
	import zest3d.applications.Zest3DApplication;
	import zest3d.localeffects.TextureEffect;
	import zest3d.primitives.TorusPrimitive;
	import zest3d.resources.Texture2D;
	
	public class Lesson01 extends Zest3DApplication implements IDisposable 
	{
		
		[Embed(source = "../../../../assets/atf/bw_checked.atf", mimeType = "application/octet-stream")]
		private const CHECKED_ATF:Class;
		private var _torus:TorusPrimitive;
		
		override protected function initialize():void 
		{
			var texture:Texture2D = Texture2D.fromByteArray(new CHECKED_ATF());
			var effect:TextureEffect = new TextureEffect(texture);
			_torus = new TorusPrimitive(effect, true, false);
			scene.addChild(_torus);
		}
		
		override protected function update(appTime:Number):void 
		{
			_torus.rotationY = appTime * 0.001;
			_torus.y = Math.sin( appTime * 0.001 );
		}
	}
}