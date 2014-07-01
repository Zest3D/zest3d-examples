package plugin.examples.particle.helpers
{
	import flash.utils.ByteArray;
	import plugin.core.interfaces.IDisposable;
	import zest3d.controllers.ParticleController;
	import zest3d.renderers.Renderer;
	import zest3d.scenegraph.Particles;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class RandomParticleController extends ParticleController implements IDisposable 
	{
		
		public function RandomParticleController() 
		{
			super();
		}
		
		override public function dispose():void 
		{
			super.dispose();
		}
		
		override protected function updatePointMotion(ctrlTime:Number):void 
		{
			var particles: Particles = _object as Particles;
			
			var numParticles: int = particles.numParticles;
			var posSizes: ByteArray = particles.positionSizes;
			posSizes.position = 0;
			
			var i: int;
			var j: int;
			for ( i = 0, j = 0; i < numParticles; ++i, j += 16 )
			{
				var symRand0: Number = symmetricRandom() * 0.01;
				var newPosSize0: Number = posSizes.readFloat() + symRand0;
				if ( newPosSize0 > 1 )
				{
					newPosSize0 = 1;
				}
				else if (newPosSize0 < -1 )
				{
					newPosSize0 = -1;
				}
				
				var symRand1: Number = symmetricRandom() * 0.01;
				var newPosSize1: Number = posSizes.readFloat() + symRand1;
				if ( newPosSize1 > 1 )
				{
					newPosSize1 = 1;
				}
				else if( newPosSize1 < -1 )
				{
					newPosSize1 = -1;
				}
				
				var symRand2: Number = symmetricRandom() * 0.01;
				var newPosSize2: Number = posSizes.readFloat() + symRand2;
				if ( newPosSize2 > 1 )
				{
					newPosSize2 = 1;
				}
				else if( newPosSize2 < -1 )
				{
					newPosSize2 = -1;
				}
				
				
				var symRand3: Number = (1 + 0.01 * symmetricRandom());
				var newPosSize3: Number = posSizes.readFloat() * symRand3;
				if ( newPosSize3 > 0.5 )
				{
					newPosSize3 = 0.5;
				}
				
				posSizes.position = j;
				posSizes.writeFloat( newPosSize0 );
				posSizes.writeFloat( newPosSize1 );
				posSizes.writeFloat( newPosSize2 );
				posSizes.writeFloat( newPosSize3 );
			}
			
			Renderer.updateAllVertexBuffer( particles.vertexBuffer );
		}
		
		private function symmetricRandom(): Number
		{
			return Math.random() -0.5;
		}
	}

}