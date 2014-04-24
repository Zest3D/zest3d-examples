package plugin.examples.dlod 
{
	import io.plugin.utils.Stats;
	import zest3d.applications.Zest3DApplication;
	import zest3d.detail.DlodNode;
	import zest3d.localeffects.ReflectionEffect;
	import zest3d.geometry.SkyboxGeometry;
	import zest3d.primitives.TorusPrimitive;
	import zest3d.resources.TextureCube;
	import zest3d.scenegraph.enum.UpdateType;
	
	/**
	 * This DLOD node example forces the torus to pop early by setting the LOD levels close to the screen.
	 * A smoother effect should be attained by setting the LOD levels based on the edge error tollerances.
	 * 
	 * @author Gary Paluk
	 */
	public class DLODExample extends Zest3DApplication 
	{
		
		[Embed(source="../../../assets/atfcube/skybox.atf", mimeType="application/octet-stream")]
		private var SkyboxATF:Class;
		
		override protected function initialize():void 
		{
			addChild( new Stats() );
			
			var skyTexture:TextureCube = TextureCube.fromByteArray( new SkyboxATF() );
			var reflectionEffect:ReflectionEffect = new ReflectionEffect( skyTexture );
			
			skybox = new SkyboxGeometry( skyTexture );
			
			var t0:TorusPrimitive = new TorusPrimitive( reflectionEffect, false, true, false, false, 128, 64 );
			var t1:TorusPrimitive = new TorusPrimitive( reflectionEffect, false, true, false, false, 64, 32 );
			var t2:TorusPrimitive = new TorusPrimitive( reflectionEffect, false, true, false, false, 32, 16 );
			var t3:TorusPrimitive = new TorusPrimitive( reflectionEffect, false, true, false, false, 16, 8 );
			var t4:TorusPrimitive = new TorusPrimitive( reflectionEffect, false, true, false, false, 8, 4 );
			
			t0.updateModelSpace( UpdateType.NORMALS );
			
			var dlod:DlodNode = new DlodNode( 5 );
			dlod.addChild( t0 );
			dlod.addChild( t1 );
			dlod.addChild( t2 );
			dlod.addChild( t3 );
			dlod.addChild( t4 );
			
			dlod.setModelDistanceAt( 0, 0, 4 );
			dlod.setModelDistanceAt( 1, 4, 6 );
			dlod.setModelDistanceAt( 2, 6, 8 );
			dlod.setModelDistanceAt( 3, 8, 10 );
			dlod.setModelDistanceAt( 4, 10, 1000 );
			
			scene.addChild( dlod );
		}
	}
}