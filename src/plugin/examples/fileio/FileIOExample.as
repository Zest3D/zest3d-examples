package plugin.examples.fileio 
{
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import plugin.core.graphics.Color;
	import plugin.core.interfaces.IDisposable;
	import plugin.utils.Stats;
	import zest3d.applications.Zest3DApplication;
	import zest3d.localeffects.TextureEffect;
	import zest3d.primitives.TorusPrimitive;
	import zest3d.resources.enum.TextureFormat;
	import zest3d.resources.Texture2D;
	import zest3d.shaders.enum.SamplerFilterType;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class FileIOExample extends Zest3DApplication implements IDisposable 
	{
		
		private var _texture:Texture2D;
		private var _torus:TorusPrimitive;
		private var _effect:TextureEffect;
		private var _textfield:TextField;
		
		private var _loadList:Array = [ "assets/textures/texture.png",
										"assets/textures/texture.jpg",
										"assets/textures/texture.gif",
										"assets/textures/texture.bmp",
										"assets/textures/texture.tga",
										"assets/textures/texture.pcx"
										]
		private var _listPointer:uint = 0;
		
		public function FileIOExample() 
		{
			super();
			_textfield = new TextField();
			_textfield.textColor = 0xFFFFFF;
			_textfield.y = 110;
			_textfield.width = 300;
			_textfield.text = "Click to cycle texture types.";
			addChild( _textfield );
		}
		
		override protected function initialize():void 
		{
			addChild( new Stats() );
			clearColor = Color.fromHexRGB( 0x222222 );
			
			_texture = new Texture2D( TextureFormat.RGBA8888 );
			
			
			//_texture.load( "assets/textures/texture.png" );
			//_texture.load( "assets/textures/texture.jpg" );
			//_texture.load( "assets/textures/texture.gif" );
			//_texture.load( "assets/textures/texture.bmp" );
			//_texture.load( "assets/textures/texture.tga" );
			//_texture.load( "assets/textures/texture.pcx" );
			
			//_texture.load( "assets/textures/texture.ico" );
			//_texture.load( "assets/textures/texture.lbm" );
			//_texture.load( "assets/textures/texture.sgi" );
			//_texture.load( "assets/textures/texture.wbmp" );
			//_texture.load( "assets/textures/texture.cur" );
			//_texture.load( "assets/textures/texture.exr" );
			//_texture.load( "assets/textures/texture.fits" );
			//_texture.load( "assets/textures/texture.pbm" );
			//_texture.load( "assets/textures/texture.pgm" );
			//_texture.load( "assets/textures/texture.pnm" );
			//_texture.load( "assets/textures/texture.xpm" );
			//_texture.load( "assets/textures/texture.sun" ); // converts but maps incorrectly
			//_texture.load( "assets/textures/texture.jpf" ); // aka jp2
			//_texture.load( "assets/textures/texture.dds" );
			
			//_texture.load( "assets/textures/texture.tif" );  // tested not working (uncompressed cmyk ??)
			//_texture.load( "assets/textures/texture.pix" );  // tested not working
			//_texture.load( "assets/textures/texture.rgb" );  // tested not working
			//_texture.load( "assets/textures/texture.rgba" ); // tested not working
			//_texture.load( "assets/textures/texture.cut" );  // tested not working
			//_texture.load( "assets/textures/texture.dcx" );  // tested not working
			//_texture.load( "assets/textures/texture.raw" );  // tested not working (planar RRR GGG, Interleaved RGBRGB, order RGB, no flip, header size 0)
			
			_effect = new TextureEffect( _texture, SamplerFilterType.LINEAR );
			_torus = new TorusPrimitive( _effect, true, false );
			
			scene.addChild( _torus );
		}
		
		override protected function update(appTime:Number):void 
		{
			_torus.rotationZ = appTime * 0.001;
			_torus.rotationY = appTime * 0.001;
			super.update(appTime);
		}
		
		override protected function onMouseDown(e:MouseEvent):Boolean 
		{
			_textfield.text = "Loading: " + _loadList[ _listPointer];
			_texture.load( _loadList[ _listPointer ] );
			if ( _listPointer >= _loadList.length - 1)
			{
				_listPointer = 0;
			}
			else
			{
				_listPointer++;
			}
			
			return false;
		}
		
		override public function get isDisposed():Boolean 
		{
			return _isDisposed;
		}
		
		override public function dispose():void 
		{
			super.dispose();
		}
		
	}

}