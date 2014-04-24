package plugin.examples.parsers 
{
	import io.plugin.core.graphics.Color;
	import io.plugin.math.algebra.APoint;
	import io.plugin.utils.Stats;
	import plugin.net.parsers.max3ds.ParserAdapter3DS;
	import zest3d.applications.Zest3DApplication;
	import zest3d.localeffects.PhongEffect;
	import zest3d.geometry.SkyboxGeometry;
	import zest3d.resources.Texture2D;
	import zest3d.resources.TextureCube;
	import zest3d.scenegraph.enum.LightType;
	import zest3d.scenegraph.enum.UpdateType;
	import zest3d.scenegraph.Light;
	import zest3d.scenegraph.TriMesh;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class Parser3DSExample extends Zest3DApplication 
	{
		[Embed(source = "../../../assets/3ds/dancer.3ds", mimeType = "application/octet-stream")]
		private var DANCER_3DS:Class;
		
		[Embed(source = "../../../assets/atf/space.atf", mimeType = "application/octet-stream")]
		private var SPACE_ATF:Class;
		
		[Embed(source = "../../../assets/atfcube/skybox.atf", mimeType = "application/octet-stream")]
		private var SKYBOX_ATF:Class;
		
		private var _dancer:TriMesh;
		override protected function initialize():void 
		{
			addChild( new Stats() );
			
			var skyboxTexture:TextureCube = TextureCube.fromByteArray( new SKYBOX_ATF() );
			skybox = new SkyboxGeometry( skyboxTexture );
			
			var light:Light = new Light( LightType.AMBIENT );
			light.position = new APoint( 5, -10, -20 );
			light.specular = new Color( 0.8, 0.8, 0.8 );
			light.exponent = 20;
			light.ambient = Color.fromHexRGB( 0x785946 )
			
			var spaceTexture:Texture2D = Texture2D.fromByteArray( new SPACE_ATF() );
			var phongEffect: PhongEffect = new PhongEffect( spaceTexture, light );
			
			var parser:ParserAdapter3DS = new ParserAdapter3DS( new DANCER_3DS(), true, true, false, false );
			parser.parse();
			
			_dancer = parser.getMeshAt( 0 );
			_dancer.effect = phongEffect;
			_dancer.scaleUniform =  10;
			_dancer.rotationX = 90 * (Math.PI / 180);
			_dancer.y = 3.5;
			_dancer.updateModelSpace( UpdateType.NORMALS );
			
			scene.addChild( _dancer );
		}
		
		override protected function update(appTime:Number):void 
		{
			_dancer.rotationZ = appTime * 0.001;
		}
		
	}

}