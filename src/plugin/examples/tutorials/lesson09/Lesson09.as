package plugin.examples.tutorials.lesson09 
{
	import flash.utils.ByteArray;
	import zest3d.applications.Zest3DApplication;
	import zest3d.localeffects.TextureEffect;
	import zest3d.geometry.ParticleGeometry;
	import zest3d.geometry.SkyboxGeometry;
	import zest3d.resources.Texture2D;
	import zest3d.resources.TextureCube;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class Lesson09 extends Zest3DApplication 
	{
		
		[Embed(source = "../../../../assets/atf/particle.atf", mimeType = "application/octet-stream")]
		private const PARTICLE_ATF:Class;
		
		[Embed(source = "../../../../assets/atfcube/skybox.atf", mimeType = "application/octet-stream")]
		private const SKYBOX_ATF:Class;
		
		private var _particles:ParticleGeometry;
		override protected function initialize():void 
		{
			skybox = new SkyboxGeometry( TextureCube.fromATFData( new SKYBOX_ATF() ));
			
			var particleTexture:Texture2D = Texture2D.fromATFData( new PARTICLE_ATF() );
			var particleEffect:TextureEffect = new TextureEffect( particleTexture );
			
			var numParticles:int = 500;
			var positionSizes:ByteArray = new ByteArray();
			for ( var i:Number = 0; i < numParticles; ++i )
			{
				positionSizes.writeFloat( (Math.random()-0.5) ); // x
				positionSizes.writeFloat( (Math.random()-0.5) ); // y
				positionSizes.writeFloat( (Math.random()-0.5) ); // z
				positionSizes.writeFloat( (Math.random() * 1) ); // scaler
			}
			
			_particles = new ParticleGeometry( particleEffect, numParticles, positionSizes );
			_particles.scaleUniform = 10;
			
			scene.addChild( _particles );
		}
		
		override protected function update(appTime:Number):void 
		{
			_particles.rotationY = appTime * -0.001;
		}
	}

}