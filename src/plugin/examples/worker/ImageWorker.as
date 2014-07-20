package plugin.examples.worker 
{
	import cmodule.zaail.CLibInit;
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.system.MessageChannel;
	import flash.system.Worker;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import plugin.image.zaail.ZaaILInterface;
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class ImageWorker extends Sprite
	{
		private var _input:ByteArray;
		private var _output:ByteArray;
		private var _bm:MessageChannel;
		private var _mb:MessageChannel;
		private var _lib:Object;
		
		private var _loader:CLibInit;
		private var _width:Number;
		private var _height:Number;
		private var _depth:Number;
		
		public function ImageWorker() 
		{
			_input = new ByteArray();
			_input.shareable = true;
			
			_output = new ByteArray();
			_output.shareable = true;
			
			_bm = Worker.current.getSharedProperty( "btm" );
			_mb = Worker.current.getSharedProperty( "mtb" );
			
			_mb.addEventListener( Event.CHANNEL_MESSAGE, onMainToBack );
			_bm.send( _input );
			_bm.send( _output );
			
			_loader = new CLibInit();
			_lib = _loader.init();
		}
		
		private function onMainToBack(e:Event):void 
		{
			if ( _mb.messageAvailable )
			{
				if ( _mb.receive() == "IMAGE READY" )
				{
					_loader.supplyFile("test", _input);
					
					_lib.ilInit();
					_lib.ilOriginFunc(ZaaILInterface.IL_ORIGIN_UPPER_LEFT);
					_lib.ilEnable(ZaaILInterface.IL_ORIGIN_SET);
					
					if(_lib.ilLoadImage("test") != 1)	// 1 means successful load
					{
						throw new Error("Could not load the selected image", "Error Loading Image");
					}
					
					_width = _lib.ilGetInteger(ZaaILInterface.IL_IMAGE_WIDTH);
					_height = _lib.ilGetInteger(ZaaILInterface.IL_IMAGE_HEIGHT);
					_depth = _lib.ilGetInteger(ZaaILInterface.IL_IMAGE_DEPTH);
					_lib.ilGetPixels(0, 0, 0, _width, _height, _depth, _output);
					
					decodeComplete(); // We locked the thread whist decoding the texture, all is ready.
				}
			}
		}
		
		private function decodeComplete():void
		{
			_bm.send( "COMPLETE" );
			_bm.send( _width );
			_bm.send( _height );
		}
		
	}

}