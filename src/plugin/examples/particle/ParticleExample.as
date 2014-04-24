package plugin.examples.particle 
{
	import flash.utils.ByteArray;
	import io.plugin.math.algebra.APoint;
	import io.plugin.utils.Stats;
	import plugin.examples.particle.helpers.RandomParticleController;
	import zest3d.applications.Zest3DApplication;
	import zest3d.localeffects.TextureEffect;
	import zest3d.geometry.ParticleGeometry;
	import zest3d.resources.Texture2D;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class ParticleExample extends Zest3DApplication 
	{
		
		[Embed(source = "../../../assets/atf/particle.atf", mimeType = "application/octet-stream")]
		private var ParticleATF:Class;
		
		private var _particles:ParticleGeometry;
		override protected function initialize():void 
		{
			addChild( new Stats() );
			camera.position = new APoint( 0, 0, -8 );
			
			var particleTexture:Texture2D = Texture2D.fromByteArray( new ParticleATF() );
			var particleEffect:TextureEffect = new TextureEffect( particleTexture );
			
			var numParticles:int = 500;
			var positionSizes:ByteArray = new ByteArray();
			for ( var i:Number = 0; i < numParticles; ++i )
			{
				positionSizes.writeFloat( (Math.random()-0.5) ); //x
				positionSizes.writeFloat( (Math.random()-0.5) ); //y
				positionSizes.writeFloat( (Math.random()-0.5) ); //z
				positionSizes.writeFloat( (Math.random() * 1) ); // scaler
			}
			
			_particles = new ParticleGeometry( particleEffect, numParticles, positionSizes );
			_particles.scaleUniform = 10;
			//_particles.addController( new RandomParticleController() ); 
			
			scene.addChild( _particles );
		}
		
		override protected function update(appTime:Number):void 
		{
			_particles.rotationY = appTime * 0.001;
		}
	}
}