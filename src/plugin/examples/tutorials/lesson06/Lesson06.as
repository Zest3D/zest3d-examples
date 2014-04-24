package plugin.examples.tutorials.lesson06 
{
	import io.plugin.core.graphics.Color;
	import zest3d.applications.Zest3DApplication;
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
	public class Lesson06 extends Zest3DApplication 
	{
		[Embed(source="../../../../assets/atfcube/skybox.atf", mimeType="application/octet-stream")]
		private var SKYBOX_ATF:Class;
		
		[Embed(source = "../../../../assets/atf/crate_wood.atf", mimeType = "application/octet-stream")]
		private const WOOD_ATF:Class;
		
		override protected function initialize():void 
		{
			var skyTexture:TextureCube = TextureCube.fromByteArray( new SKYBOX_ATF() );
			var woodTexture:Texture2D = Texture2D.fromByteArray(new WOOD_ATF());
			
			skybox = new SkyboxGeometry( skyTexture );
			
			var light:Light = new Light();
			light.ambient = new Color(0.2, 0.2, 0.2);
			light.specular = new Color(0.5, 0.5, 0.5);
			light.exponent = 10;
			
			var lightNode:LightNode = new LightNode(light);
			scene.addChild(lightNode);
			lightNode.translate(5, 5, -5);
			
			var phongEffect:PhongEffect = new PhongEffect(woodTexture, light);
			
			var torus:TorusPrimitive = new TorusPrimitive(phongEffect, true, true);
			scene.addChild(torus);
		}
	}
}