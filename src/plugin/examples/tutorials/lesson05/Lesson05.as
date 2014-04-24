package plugin.examples.tutorials.lesson05 
{
	import zest3d.applications.Zest3DApplication;
	import zest3d.detail.DlodNode;
	import zest3d.localeffects.ReflectionEffect;
	import zest3d.geometry.SkyboxGeometry;
	import zest3d.primitives.TorusPrimitive;
	import zest3d.resources.TextureCube;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class Lesson05 extends Zest3DApplication 
	{
		[Embed(source="../../../../assets/atfcube/skybox.atf", mimeType="application/octet-stream")]
		private var SKYBOX_ATF:Class;
		
		override protected function initialize():void 
		{
			var skyTexture:TextureCube = TextureCube.fromByteArray( new SKYBOX_ATF() );
			var reflectionEffect:ReflectionEffect = new ReflectionEffect( skyTexture );
			
			skybox = new SkyboxGeometry( skyTexture );
			
			var t0:TorusPrimitive = new TorusPrimitive( reflectionEffect, false, true, false, false, 128, 64 );
			var t1:TorusPrimitive = new TorusPrimitive( reflectionEffect, false, true, false, false, 16, 8 );
			var t2:TorusPrimitive = new TorusPrimitive( reflectionEffect, false, true, false, false, 10, 5 );
			
			var dlod:DlodNode = new DlodNode( 3 );
			dlod.addChild( t0 );
			dlod.addChild( t1 );
			dlod.addChild( t2 );
			
			dlod.setModelDistanceAt( 0, 0, 5 );
			dlod.setModelDistanceAt( 1, 5, 10 );
			dlod.setModelDistanceAt( 2, 10, 1000 );
			
			scene.addChild( dlod );
		}
		
	}

}