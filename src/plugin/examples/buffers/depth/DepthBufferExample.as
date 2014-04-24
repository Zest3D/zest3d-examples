package plugin.examples.buffers.depth 
{
	import io.plugin.math.algebra.APoint;
	import io.plugin.utils.Stats;
	import zest3d.applications.Zest3DApplication;
	import zest3d.localeffects.DepthEffect;
	import zest3d.primitives.CubePrimitive;
	import zest3d.primitives.PlanePrimitive;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class DepthBufferExample extends Zest3DApplication 
	{
		
		override protected function initialize():void 
		{
			addChild( new Stats() );
			
			camera.position = new APoint( 0, 0, -10 );
			var depthEffect:DepthEffect = new DepthEffect();
			
			var cube0:CubePrimitive = new CubePrimitive( depthEffect, false, false );
			cube0.x = -3
			scene.addChild( cube0 );
			
			var cube1:CubePrimitive = new CubePrimitive( depthEffect, false, false );
			cube1.x = 3
			scene.addChild( cube1 );
			
			var cube2:CubePrimitive = new CubePrimitive( depthEffect, false, false );
			scene.addChild( cube2 );
			
			var plane0:PlanePrimitive = new PlanePrimitive( depthEffect, false, false, false, false, 2, 2, 10000, 10000 );
			plane0.rotationX = 90 * (Math.PI / 180 );
			plane0.y = 3;
			scene.addChild( plane0 );
			
			var plane1:PlanePrimitive = new PlanePrimitive( depthEffect, false, false, false, false, 2, 2, 10000, 10000 );
			plane1.rotationX = 270 * (Math.PI / 180 );
			plane1.y = -3;
			scene.addChild( plane1 );
		}
		
	}

}