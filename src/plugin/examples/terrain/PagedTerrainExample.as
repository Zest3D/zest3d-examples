package plugin.examples.terrain 
{
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import io.plugin.core.graphics.Color;
	import io.plugin.math.algebra.APoint;
	import io.plugin.utils.Stats;
	import zest3d.applications.Zest3DApplication;
	import zest3d.localeffects.PhongEffect;
	import zest3d.geometry.SkyboxGeometry;
	import zest3d.resources.enum.AttributeType;
	import zest3d.resources.enum.AttributeUsageType;
	import zest3d.resources.Texture2D;
	import zest3d.resources.TextureCube;
	import zest3d.resources.VertexFormat;
	import zest3d.scenegraph.enum.LightType;
	import zest3d.scenegraph.enum.UpdateType;
	import zest3d.scenegraph.Light;
	import zest3d.terrain.Terrain;
	import zest3d.terrain.TerrainPage;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class PagedTerrainExample extends Zest3DApplication 
	{
		
		[Embed(source = "../../../assets/atf/grass.atf", mimeType = "application/octet-stream")]
		private var SPACE_ATF:Class;
		
		[Embed(source = "../../../assets/atfcube/skybox.atf", mimeType = "application/octet-stream")]
		private var SKYBOX_ATF:Class;
		
		private var _terrain:Terrain;
		private var _textfield:TextField;
		override protected function initialize():void 
		{
			addChild( new Stats() );
			camera.position = new APoint( 0, -4, 0 );
			
			var vFormat:VertexFormat = new VertexFormat( 3 );
			vFormat.setAttribute( 0, 0, 0, AttributeUsageType.POSITION, AttributeType.FLOAT3, 0 );
			vFormat.setAttribute( 1, 0, 12, AttributeUsageType.TEXCOORD, AttributeType.FLOAT2, 0 );
			vFormat.setAttribute( 2, 0, 20, AttributeUsageType.NORMAL, AttributeType.FLOAT3, 0 );
			vFormat.stride = 32;
			
			_terrain = new Terrain( "terrain", vFormat, _camera );
			_terrain.rotationX = 90 * (Math.PI / 180 );
			
			var light:Light = new Light();
			light.position = new APoint( -100, -100, -100 );
			light.ambient = new Color( 0, 0, 0 );
			light.specular = new Color( 0.46, 0.21, 0.21 );
			light.exponent = 1;
			
			var texture:Texture2D = Texture2D.fromByteArray( new SPACE_ATF() );
			
			var effect:PhongEffect = new PhongEffect( texture, light );
			
			for ( var i:int = 0; i < _terrain.rowQuantity; ++i )
			{
				for ( var j:int = 0; j < _terrain.colQuantity; ++j )
				{
					var cell:TerrainPage = _terrain.getPage( i, j );
					cell.updateModelSpace( UpdateType.NORMALS );
					cell.effect = effect;
				}
			}
			
			scene.addChild( _terrain );
			
			var skyboxTexture:TextureCube = TextureCube.fromByteArray( new SKYBOX_ATF() );
			skybox = new SkyboxGeometry( skyboxTexture );
			
			_textfield = new TextField();
			_textfield.textColor = 0xFFFFFF;
			_textfield.y = 100;
			addChild( _textfield );
		}
		
		override protected function update(appTime:Number):void 
		{
			_terrain.onCameraMotion();
			_textfield.text = "numVisible: " + numVisibleObjects;
		}
		
		override protected function onMouseDown(e:MouseEvent):Boolean 
		{
			return false;
		}
	}
}