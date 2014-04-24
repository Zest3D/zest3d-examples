package plugin.examples.buffers.albedo 
{
	import io.plugin.core.graphics.Color;
	import io.plugin.math.algebra.APoint;
	import io.plugin.utils.Stats;
	import zest3d.applications.Zest3DApplication;
	import zest3d.localeffects.TextureEffect;
	import zest3d.primitives.PlanePrimitive;
	import zest3d.primitives.TorusPrimitive;
	import zest3d.resources.Texture2D;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class AlbedoBufferExample extends Zest3DApplication 
	{
		
		[Embed(source = "../../../../assets/atf/bw_checked.atf", mimeType = "application/octet-stream")]
		private var SpaceATF:Class;
		
		private var _torus0:TorusPrimitive;
		private var _torus1:TorusPrimitive;
		private var _torus2:TorusPrimitive;
		
		override protected function initialize():void 
		{
			addChild( new Stats() );
			
			clearColor = Color.fromHexRGB( 0x111111 );
			
			camera.position = new APoint( 0, 0, -10 );
			
			var texture2D:Texture2D = Texture2D.fromByteArray( new SpaceATF() );
			var texture2DEffect:TextureEffect = new TextureEffect( texture2D );
			
			_torus0 = new TorusPrimitive( texture2DEffect, true, false, false, false, 64, 32 );
			_torus0.x = -3;
			scene.addChild( _torus0 );
			
			_torus1 = new TorusPrimitive( texture2DEffect, true, false, false, false, 64, 32 );
			scene.addChild( _torus1 );
			
			_torus2 = new TorusPrimitive( texture2DEffect, true, false, false, false, 64, 32 );
			_torus2.x = 3;
			scene.addChild( _torus2 );
			
			var plane0:PlanePrimitive = new PlanePrimitive( texture2DEffect, true, false, false, false, 2, 2, 5, 5, true );
			plane0.rotationX = 90 * (Math.PI / 180 );
			plane0.y = 3;
			scene.addChild( plane0 );
			
			var plane1:PlanePrimitive = new PlanePrimitive( texture2DEffect, true, false, false, false, 2, 2, 5, 5, true );
			plane1.rotationX = 270 * (Math.PI / 180 );
			plane1.y = -3;
			scene.addChild( plane1 );
		}
		
		override protected function update(appTime:Number):void 
		{
			_torus0.rotationY += 0.1;
			_torus1.rotationY -= 0.1;
			_torus2.rotationY += 0.1;
		}
		
	}

}