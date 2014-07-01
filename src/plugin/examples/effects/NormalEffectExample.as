package plugin.examples.effects 
{
	import plugin.core.interfaces.IDisposable;
	import zest3d.applications.Zest3DApplication;
	import zest3d.localeffects.NormalEffect;
	import zest3d.primitives.PlanePrimitive;
	import zest3d.primitives.TorusPrimitive;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class NormalEffectExample extends Zest3DApplication implements IDisposable 
	{
		
		[Embed(source = "../../../assets/atf/bw_checked.atf", mimeType = "application/octet-stream")]
		private const STRIPES_ATF:Class;
		
		override public function dispose():void 
		{
			super.dispose();
		}
		
		override protected function initialize():void 
		{
			var effect:NormalEffect = new NormalEffect();
			
			var torus:TorusPrimitive = new TorusPrimitive( effect, false, true );
			scene.addChild( torus );
			
			var p1:PlanePrimitive = new PlanePrimitive(effect, false, true);
			p1.rotationX = 270 * (Math.PI / 180 );
			p1.y = -2;
			p1.scaleUniform = 10;
			scene.addChild( p1 );
			
			var p2:PlanePrimitive = new PlanePrimitive(effect, false, true);
			p2.rotationX = 90 * (Math.PI / 180 );
			p2.y = 2;
			p2.scaleUniform = 10;
			scene.addChild( p2 );
		}
		
		override protected function update(appTime:Number):void 
		{
			super.update(appTime);
		}
		
	}

}