package plugin.screens.screen03 
{
	import io.plugin.core.graphics.Color;
	import zest3d.applications.Zest3DApplication;
	import zest3d.localeffects.CartoonEffect;
	import zest3d.localeffects.GlassEffect;
	import zest3d.localeffects.PhongEffect;
	import zest3d.localeffects.ReflectionEffect;
	import zest3d.localeffects.TextureEffect;
	import zest3d.geometry.SkyboxGeometry;
	import zest3d.primitives.SpherePrimitive;
	import zest3d.resources.Texture2D;
	import zest3d.resources.TextureCube;
	import zest3d.scenegraph.enum.CullingType;
	import zest3d.scenegraph.enum.LightType;
	import zest3d.scenegraph.Light;
	import zest3d.scenegraph.LightNode;
	import zest3d.scenegraph.TriMesh;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class Screen03 extends Zest3DApplication 
	{
		
		[Embed(source = "../../../assets/atf/bw_checked.atf", mimeType = "application/octet-stream")]
		private const CHECKED_ATF:Class;
		
		[Embed(source = "../../../assets/atf/toon_gradient2.atf", mimeType = "application/octet-stream")]
		private const GRADIENT_ATF:Class;
		
		[Embed(source = "../../../assets/atfcube/rock_water.atf", mimeType = "application/octet-stream")]
		private const ROCK_WATER_ATF:Class;
		
		[Embed(source = "../../../assets/atf/crate_wood.atf", mimeType = "application/octet-stream")]
		private const WOOD_ATF:Class;
		
		override protected function initialize():void 
		{
			clearColor = new Color( 0, 0, 0 );
			
			var checkedTexture: Texture2D = Texture2D.fromByteArray( new CHECKED_ATF() );
			var gradientTexture: Texture2D = Texture2D.fromByteArray( new GRADIENT_ATF() );
			var rockWaterTexture: TextureCube = TextureCube.fromByteArray( new ROCK_WATER_ATF() );
			var woodTexture:Texture2D = Texture2D.fromByteArray( new WOOD_ATF() );
			
			var light:Light = new Light( LightType.POINT );
			light.ambient = new Color( 0.1, 0.1, 0.1 );
			light.specular = new Color( 0.9, 0.9, 0.9, 50 );
			light.exponent = 10;
			
			var lightNode:LightNode = new LightNode(light);
			lightNode.translate( 1, -10, -5 );
			
			var cartoonEffect:CartoonEffect = new CartoonEffect( checkedTexture, gradientTexture, light );
			var textureEffect:TextureEffect = new TextureEffect( checkedTexture );
			var glassEffect:GlassEffect = new GlassEffect( rockWaterTexture );
			var phongEffect:PhongEffect = new PhongEffect( woodTexture, light );
			var reflectionEffect:ReflectionEffect = new ReflectionEffect( rockWaterTexture );
			
			skybox = new SkyboxGeometry( rockWaterTexture );
			
			var d0:SpherePrimitive = new SpherePrimitive( textureEffect, true, false );
			d0.culling = CullingType.NEVER;
			d0.rotationX = 90 * (Math.PI / 180);
			d0.x = -6;
			
			var d1:SpherePrimitive = new SpherePrimitive( phongEffect, true, true );
			d1.rotationX = 90 * (Math.PI / 180);
			d1.x = -3;
			
			var d2:SpherePrimitive = new SpherePrimitive( reflectionEffect, false, true );
			d2.rotationX = 90 * (Math.PI / 180);
			d2.x = 0;
			
			var d3:TriMesh = new SpherePrimitive( glassEffect, false, true );
			d3.rotationX = 90 * (Math.PI / 180);
			d3.x = 3;
			
			var d4:TriMesh = new SpherePrimitive( cartoonEffect, true, true );
			d4.rotationX = 90 * (Math.PI / 180);
			d4.x = 6;
			
			scene.addChild( lightNode );
			
			scene.addChild( d0 );
			scene.addChild( d1 );
			scene.addChild( d2 );
			scene.addChild( d3 );
			scene.addChild( d4 );
		}
		
	}

}