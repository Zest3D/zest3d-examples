package plugin.examples.tutorials.lesson02 
{
	import zest3d.applications.Zest3DApplication;
	import zest3d.geometry.SkyboxGeometry;
	import zest3d.resources.TextureCube;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class Lesson02 extends Zest3DApplication 
	{
		[Embed(source="../../../../assets/atfcube/skybox.atf", mimeType="application/octet-stream")]
		private var SKYBOX_ATF:Class;
		
		override protected function initialize():void 
		{
			var skyboxTexture:TextureCube = TextureCube.fromByteArray(new SKYBOX_ATF());
			skybox = new SkyboxGeometry(skyboxTexture);
		}
	}
}