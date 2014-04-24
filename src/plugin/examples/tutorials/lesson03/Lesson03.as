package plugin.examples.tutorials.lesson03 
{
	import zest3d.applications.Zest3DApplication;
	import zest3d.localeffects.ReflectionEffect;
	import zest3d.geometry.SkyboxGeometry;
	import zest3d.primitives.TorusPrimitive;
	import zest3d.resources.TextureCube;
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class Lesson03 extends Zest3DApplication 
	{
		[Embed(source="../../../../assets/atfcube/skybox.atf", mimeType="application/octet-stream")]
		private var SKYBOX_ATF:Class;
		
		private var _torus:TorusPrimitive;
		
		override protected function initialize():void 
		{
			var skyboxTexture:TextureCube = TextureCube.fromByteArray(new SKYBOX_ATF());
			skybox = new SkyboxGeometry(skyboxTexture);
			var reflectionEffect:ReflectionEffect = new ReflectionEffect(skyboxTexture);
			_torus = new TorusPrimitive(reflectionEffect, false, true);
			scene.addChild(_torus);
		}
	}
}