package plugin.examples.reflections 
{
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	import io.plugin.core.graphics.Color;
	import io.plugin.math.algebra.APoint;
	import zest3d.applications.Zest3DApplication;
	import zest3d.geometry.ParticleGeometry;
	import zest3d.geometry.SkyboxGeometry;
	import zest3d.globaleffects.PlanarReflectionEffect;
	import zest3d.localeffects.FlatMaterialEffect;
	import zest3d.localeffects.PhongEffect;
	import zest3d.localeffects.TextureEffect;
	import zest3d.primitives.CubePrimitive;
	import zest3d.primitives.PlanePrimitive;
	import zest3d.primitives.SpherePrimitive;
	import zest3d.resources.Texture2D;
	import zest3d.resources.TextureCube;
	import zest3d.scenegraph.Culler;
	import zest3d.scenegraph.enum.CullingType;
	import zest3d.scenegraph.Light;
	import zest3d.scenegraph.LightNode;
	import zest3d.scenegraph.Material;
	import zest3d.scenegraph.TriMesh;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class PlanarReflectionEffectExample extends Zest3DApplication 
	{
		
		[Embed(source = "../../../assets/atf/particle.atf", mimeType = "application/octet-stream")]
		private var PARTICLE_ATF:Class;
		
		[Embed(source = "../../../assets/atfcube/bw_stripes.atf", mimeType = "application/octet-stream")]
		private var BW_STRIPES_ATF:Class;
		
		[Embed(source = "../../../assets/atf/bw_checked.atf", mimeType = "application/octet-stream")]
		private var BW_CHECKED_ATF:Class;
		
		[Embed(source="../../../assets/atf/space.atf", mimeType="application/octet-stream")]
		private var SPACE_ATF:Class;
		
		private var _sceneCuller:Culler;
		private var _meshCuller:Culler;
		private var _prEffect:PlanarReflectionEffect;
		
		private var _plane0:PlanePrimitive;
		private var _plane1:PlanePrimitive;
		private var _plane2:PlanePrimitive;
		
		private var _mesh:TriMesh;
		private var _lightNode:LightNode;
		private var _particles:ParticleGeometry;
		
		override protected function initialize():void 
		{
			// addChild( new Stats() );
			camera.position = new APoint( 0, -2, -7 );
			clearColor = new Color( 0, 0, 0, 0 );
			
			var bwCheckedTexture:Texture2D = Texture2D.fromByteArray( new BW_CHECKED_ATF() );
			var spaceTexture:Texture2D = Texture2D.fromByteArray( new SPACE_ATF() );
			var bwStripedTexture:TextureCube = TextureCube.fromByteArray( new BW_STRIPES_ATF() );
			
			var light:Light = new Light();
			light.ambient = new Color( 0.2, 0.2, 0.2 );
			light.specular = new Color( 1, 1, 1 );
			light.exponent = 5;
			
			_lightNode = new LightNode( light );
			_lightNode.position = new APoint( 0, -2, 0 );
			
			var phongSpaceEffect:PhongEffect = new PhongEffect( spaceTexture, light );
			var phongCheckEffect:PhongEffect = new PhongEffect( bwCheckedTexture, light );
			var bwChecked2DEffect:TextureEffect = new TextureEffect( bwCheckedTexture );
			
			_sceneCuller = new Culler( _camera );
			_meshCuller = new Culler( _camera );
			
			_plane0 = new PlanePrimitive( phongCheckEffect, true, true, false, false, 2, 2, 3, 3, true );
			_plane0.rotationX = 90 * (Math.PI / 180);
			
			_plane1 = new PlanePrimitive( phongCheckEffect, true, true, false, false, 2, 2, 3, 3, true );
			_plane1.rotationX = 180 * (Math.PI / 180);
			_plane1.z = 3;
			_plane1.y = -3;
			
			_plane2 = new PlanePrimitive( phongCheckEffect, true, true, false, false, 2, 2, 3, 3, true );
			_plane2.rotationY = 270 * (Math.PI / 180);
			_plane2.x = 3;
			_plane2.y = -3;
			
			var material:Material = new Material();
			material.ambient = Color.fromHexRGB( 0xFFFFFF );
			var flatMaterialEffect:FlatMaterialEffect = new FlatMaterialEffect( material );
			
			var lightSphere:SpherePrimitive = new SpherePrimitive( flatMaterialEffect, false, false, false, false, 16, 16, 0.2 );	
			
			_mesh = new CubePrimitive( phongCheckEffect, true, true );
			_mesh.effect = phongSpaceEffect;
			_mesh.scaleUniform = 0.5;
			_mesh.rotationX = 90 * ( Math.PI / 180 );
			_mesh.culling = CullingType.NEVER;				// prevent this geometry from ever being culled
			
			_prEffect = new PlanarReflectionEffect( 3 );
			_prEffect.setPlaneAt( 0, _plane0 );
			_prEffect.setReflectanceAt( 0, 1 );
			_prEffect.setPlaneAt( 1, _plane1 );
			_prEffect.setReflectanceAt( 1, 1 );
			_prEffect.setPlaneAt( 2, _plane2 );
			_prEffect.setReflectanceAt( 2, 1 );
			
			_lightNode.addChild( lightSphere );
			
			var particleTexture:Texture2D = Texture2D.fromByteArray( new PARTICLE_ATF() );
			var particleEffect:TextureEffect = new TextureEffect( particleTexture );
			
			var numParticles:int = 500;
			var positionSizes:ByteArray = new ByteArray();
			for ( var i:Number = 0; i < numParticles; ++i )
			{
				positionSizes.writeFloat( (Math.random()-0.5) ); //x
				positionSizes.writeFloat( (Math.random()-0.5) ); //y
				positionSizes.writeFloat( (Math.random()-0.5) ); //z
				positionSizes.writeFloat( (Math.random() * 1.5) ); // scaler
			}
			
			_particles = new ParticleGeometry( particleEffect, numParticles, positionSizes );
			_particles.scaleUniform = 20;
			
			scene.addChild( _plane0 );
			scene.addChild( _plane1 );
			scene.addChild( _plane2 );
			scene.addChild( _mesh );
			scene.addChild( _particles );
			
			scene.rotationY = -45 * ( Math.PI / 180 );
			
			skybox = new SkyboxGeometry( bwStripedTexture );
		}
		
		override public function onIdle():void 
		{
			measureTime();
			update( getTimer() );
			
			if ( moveCamera() )
			{
				_sceneCuller.computeVisibleSet( scene );
				_meshCuller.computeVisibleSet( _mesh );
			}
			
			if ( moveObject() )
			{
				scene.update();
				_mesh.update();
				_sceneCuller.computeVisibleSet( scene );
				_meshCuller.computeVisibleSet( _mesh );
			}
			
			if ( _renderer.preDraw() )
			{
				_renderer.clearBuffers();
				_renderer.drawVisibleSet( _sceneCuller.visibleSet );
				_renderer.drawVisibleSet( _meshCuller.visibleSet, _prEffect );
				if( skybox )
				{
					skybox.position = _camera.position;
					skybox.update();
					_renderer.drawVisual( skybox );
				}
				if ( _particles )
				{
					_renderer.drawVisual( _particles );
				}
				_renderer.postDraw();
				_renderer.displayColorBuffer();
			}
			
			updateFrameCount();
		}
		
		override protected function update(appTime:Number):void 
		{
			_mesh.rotationZ = appTime * 0.001;
			_mesh.y = Math.sin( appTime * 0.001 ) - 2;
			_lightNode.x = ((Math.cos( appTime * 0.0005 ) )) * 2.5;
			_lightNode.z = ((Math.sin( appTime * 0.0005 ) )) * 2.5;
			_lightNode.update();
			_particles.rotationY = appTime * 0.0005;
		}
	}
}