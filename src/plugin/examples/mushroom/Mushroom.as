package plugin.examples.mushroom 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import io.plugin.core.graphics.Color;
	import io.plugin.math.algebra.APoint;
	import zest3d.applications.Zest3DApplication;
	import zest3d.localeffects.FlatMaterialEffect;
	import zest3d.geometry.SkyboxGeometry;
	import zest3d.primitives.CubePrimitive;
	import zest3d.resources.Texture2D;
	import zest3d.resources.TextureCube;
	import zest3d.scenegraph.Material;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class Mushroom extends Zest3DApplication 
	{
		[Embed(source = "../../../assets/atf/bw_checked.atf", mimeType = "application/octet-stream")]
		private const CHECKED_ATF:Class;
		
		[Embed(source="../../../assets/audio/Overworld_Theme.mp3")]
		private const MARIO_SND:Class;
		
		[Embed(source = "../../../assets/png/zest_logo.png")]
		private const ZEST_LOGO_PNG:Class;
		
		[Embed(source = "../../../assets/atfcube/rock_water.atf", mimeType = "application/octet-stream")]
		private const SKYBOX_ATF:Class;
		
		private var _colors:Array;
		private var _data:Array;
		private var _effects:Array;
		private var _models:Array;
		private var _soundChannel:SoundChannel;
		
		override protected function initialize():void 
		{
			skybox = new SkyboxGeometry( TextureCube.fromByteArray( new SKYBOX_ATF() ) );
			
			camera.position = new APoint( 0, 0, -80 );
			clearColor = new Color( 0.2, 0.2, 0.2 );
			
			var black:Color = Color.fromHexRGB( 0x000000 );
			var white:Color = Color.fromHexRGB( 0xFFFFFF );
			var red:Color = Color.fromHexRGB( 0xFF0000 );
			var green:Color = Color.fromHexRGB( 0x00FF00 );
			
			_colors = [null, black, white, red, green];
			
			_data = [];
			_data[0] = [0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0];
			_data[1] = [0, 0, 0, 1, 1, 1, 3, 2, 2, 3, 1, 1, 1, 0, 0, 0];
			_data[2] = [0, 0, 1, 1, 3, 3, 3, 2, 2, 3, 3, 3, 1, 1, 0, 0];
			_data[3] = [0, 1, 1, 2, 3, 3, 2, 2, 2, 2, 3, 3, 2, 1, 1, 0];
			_data[4] = [0, 1, 3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 1, 0];
			_data[5] = [1, 1, 3, 3, 2, 2, 3, 3, 3, 3, 2, 2, 3, 3, 1, 1];
			_data[6] = [1, 3, 3, 3, 2, 3, 3, 3, 3, 3, 3, 2, 3, 3, 3, 1];
			_data[7] = [1, 3, 3, 3, 2, 3, 3, 3, 3, 3, 3, 2, 3, 3, 3, 1];
			_data[8] = [1, 3, 3, 2, 2, 3, 3, 3, 3, 3, 3, 2, 2, 3, 3, 1];
			_data[9] = [1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 2, 2, 2, 2, 2, 1];
			_data[10] = [1, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 1];
			_data[11] = [1, 1, 1, 1, 2, 2, 1, 2, 2, 1, 2, 2, 1, 1, 1, 1];
			_data[12] = [0, 1, 1, 2, 2, 2, 1, 2, 2, 1, 2, 2, 2, 1, 1, 0];
			_data[13] = [0, 0, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 0, 0];
			_data[14] = [0, 0, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 0, 0];
			_data[15] = [0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0];
		   
			var texture:Texture2D = Texture2D.fromByteArray( new CHECKED_ATF() );
			
			_effects = [];
			for ( var c:int = 0; c < _colors.length; ++c )
			{
				var material:Material = new Material();
				material.ambient =  _colors[c];
				_effects[c]= new FlatMaterialEffect( material );
			}
		   
			_models = [];
			var cube:CubePrimitive;
			
			const SPACING:Number = 2;
			const HALF_DIM:Number = (SPACING * _data.length-1)/2;
			for ( var i:int = 0; i < _data.length; ++i )
			{
				var row:Array = _data[i];
				_models[i] = [];
				for ( var j:int = 0; j < row.length; ++j )
				{
					if ( _data[i][j] )
					{
						cube = new CubePrimitive( _effects[ _data[i][j] ], false, false );
						cube.translate( (j * SPACING)-HALF_DIM, (i * SPACING)-HALF_DIM, 0 );
						cube.name = "Cube_" + i + "_" + j;
						scene.addChild( cube );
						_models[i][j] = cube;
					}
				}
			}
		   
			var audio:Sound = new MARIO_SND();
			_soundChannel = new SoundChannel();
			_soundChannel = audio.play(0, 9999);
			
			var logo:Sprite = new Sprite();
			var logoBmp:Bitmap = new ZEST_LOGO_PNG();
			logo.addChild( logoBmp );
			
			logo.width = logo.height = 100;
			logo.x = 5;
			logo.y = 8;
			logo.addEventListener( MouseEvent.CLICK, onLogoClick );
			logo.buttonMode = true;
			addChild( logo );
			
			initializeCameraMotion( 0.7, 0.05 );
		}
		
		private function onLogoClick(e:MouseEvent ):void
		{
			var request:URLRequest = new URLRequest("http://www.zest3d.com");
			navigateToURL(request, "_blank");
		}
		
		override protected function update(appTime:Number):void 
		{
			for ( var i:int = 0; i < _models.length; ++i )
			{
				var row:Array = _models[i];
				for ( var j:int = 0; j < row.length; ++j )
				{
					if ( _models[i][j] )
					{
						_models[i][j].scaleUniform = ((_soundChannel.leftPeak + _soundChannel.rightPeak) / 2) + 0.7;
						_models[i][j].z = Math.sin( (appTime * 0.001) + j%(i+j+1) );
					}
				}
			}
		}
	}

}