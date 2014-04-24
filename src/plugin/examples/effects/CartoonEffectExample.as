package plugin.examples.effects 
{
	import io.plugin.core.graphics.Color;
	import io.plugin.math.algebra.APoint;
	import io.plugin.utils.Stats;
	import plugin.net.parsers.max3ds.ParserAdapter3DS;
	import zest3d.applications.Zest3DApplication;
	import zest3d.localeffects.CartoonEffect;
	import zest3d.resources.Texture2D;
	import zest3d.scenegraph.enum.LightType;
	import zest3d.scenegraph.enum.UpdateType;
	import zest3d.scenegraph.Light;
	import zest3d.scenegraph.TriMesh;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class CartoonEffectExample extends Zest3DApplication 
	{
		
		[Embed(source = "../../../assets/atf/bw_checked.atf", mimeType = "application/octet-stream")]
		private var CHECKED_ATF:Class;
		
		[Embed(source = "../../../assets/atf/toon_gradient2.atf", mimeType = "application/octet-stream")]
		private var GRADIENT:Class;
		
		[Embed(source = "../../../assets/3ds/dancer.3ds", mimeType = "application/octet-stream")]
		private var DANCER_3DS:Class;
		
		private var _dancer:TriMesh;
		
		override protected function initialize():void 
		{
			addChild( new Stats() );
			
			clearColor = new Color( 0, 0, 0 );
			
			var parser:ParserAdapter3DS = new ParserAdapter3DS( new DANCER_3DS(), true, true );
			parser.parse();
			
			var checkedTexture: Texture2D = Texture2D.fromByteArray( new CHECKED_ATF() );
			var gradientTexture: Texture2D = Texture2D.fromByteArray( new GRADIENT() );
			
			var light:Light = new Light( LightType.POINT );
			light.position = new APoint( 1, -10, -5 );
			light.ambient = new Color( 0.1, 0.1, 0.1 );
			light.specular = new Color( 0.9, 0.9, 0.9, 50 );
			
			var cartoonEffect:CartoonEffect = new CartoonEffect( checkedTexture, gradientTexture, light );
			_dancer = parser.getMeshAt( 0 );
			_dancer.updateModelSpace( UpdateType.NORMALS );
			_dancer.effect = cartoonEffect;
			_dancer.rotationX = 90 * (Math.PI / 180);
			_dancer.scaleUniform = 8;
			_dancer.y = 3;
			
			scene.addChild( _dancer );
		}
		
		override protected function update(appTime:Number):void 
		{
			_dancer.rotationZ = appTime * 0.001;
		}
		
	}

}