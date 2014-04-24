package plugin.examples.tutorials.lesson07 
{
	import flash.display3D.textures.Texture;
	import io.plugin.math.algebra.APoint;
	import plugin.net.parsers.max3ds.ParserAdapter3DS;
	import zest3d.applications.Zest3DApplication;
	import zest3d.localeffects.GlassEffect;
	import zest3d.localeffects.SkyboxEffect;
	import zest3d.localeffects.TextureEffect;
	import zest3d.geometry.SkyboxGeometry;
	import zest3d.resources.Texture2D;
	import zest3d.resources.TextureCube;
	import zest3d.scenegraph.enum.UpdateType;
	import zest3d.scenegraph.TriMesh;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class Lesson07 extends Zest3DApplication 
	{
		[Embed(source = "../../../../assets/3ds/dancer.3ds", mimeType = "application/octet-stream")]
		private var DANCER_3DS:Class;
		
		[Embed(source = "../../../../assets/atfcube/skybox.atf", mimeType = "application/octet-stream")]
		private var SKYBOX_ATF:Class;
		
		private var _dancer:TriMesh;
		override protected function initialize():void 
		{
			camera.position = new APoint( 0, -0.4, -0.6 );
			var skyboxTexture:TextureCube = TextureCube.fromByteArray(new SKYBOX_ATF());
			skybox = new SkyboxGeometry(skyboxTexture);
			
			var glassEffect:GlassEffect = new GlassEffect(skyboxTexture);
			
			var parser:ParserAdapter3DS = new ParserAdapter3DS(new DANCER_3DS(), false, true);
			parser.parse();
			
			_dancer = parser.getMeshAt(0);
			_dancer.effect = glassEffect;
			_dancer.rotationX = 90 * (Math.PI / 180);
			
			scene.addChild(_dancer);
		}
		
		override protected function update(appTime:Number):void 
		{
			_dancer.rotationZ = appTime * 0.001;
		}
	}
}