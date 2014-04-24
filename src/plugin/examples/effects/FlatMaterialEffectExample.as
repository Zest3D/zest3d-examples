package plugin.examples.effects 
{
	import io.plugin.core.graphics.Color;
	import io.plugin.utils.Stats;
	import zest3d.applications.Zest3DApplication;
	import zest3d.localeffects.FlatMaterialEffect;
	import zest3d.primitives.TorusPrimitive;
	import zest3d.scenegraph.Material;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class FlatMaterialEffectExample extends Zest3DApplication 
	{
		
		private var _torus0:TorusPrimitive;
		
		override protected function initialize():void 
		{
			addChild( new Stats() );
			clearColor = Color.fromHexRGB( 0x000000 );
			
			var material:Material = new Material();
			material.ambient = Color.fromHexRGB( 0xE937B9 );
			var materialEffect:FlatMaterialEffect = new FlatMaterialEffect( material );
			
			_torus0 = new TorusPrimitive( materialEffect, false, false );
			
			scene.addChild( _torus0 );
		}
		
		override protected function update(appTime:Number):void 
		{
			_torus0.rotationY += 0.05;
		}
	}

}