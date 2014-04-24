package plugin.examples.effects 
{
	import io.plugin.core.graphics.Color;
	import io.plugin.math.algebra.APoint;
	import io.plugin.utils.Stats;
	import zest3d.applications.Zest3DApplication;
	import zest3d.localeffects.DiffuseNormalSpecularEffect;
	import zest3d.geometry.SkyboxGeometry;
	import zest3d.primitives.TorusPrimitive;
	import zest3d.resources.Texture2D;
	import zest3d.resources.TextureCube;
	import zest3d.scenegraph.Light;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class DiffuseNormalSpecularEffectExample extends Zest3DApplication
	{
		
		[Embed(source = "../../../assets/atfcube/rock_water.atf", mimeType = "application/octet-stream")]
		private const skyboxATF:Class;
		
		[Embed(source = "../../../assets/atf/brick_d.atf", mimeType = "application/octet-stream")]
		private const diffuseATF:Class;
		
		[Embed(source = "../../../assets/atf/brick_n.atf", mimeType = "application/octet-stream")]
		private const normalATF:Class;
		
		override protected function initialize():void 
		{
			addChild( new Stats() );
			
			skybox = new SkyboxGeometry( TextureCube.fromByteArray( new skyboxATF() ) );
			
			var light:Light = new Light();
			light.position = new APoint( 100, -50, -100 );
			light.ambient = new Color( 0.3, 0.3, 0.5 );
			light.specular = new Color( 0.15, 0.15, 0.3 );
			light.exponent = 50;
			
			var diffuseMap:Texture2D = Texture2D.fromByteArray( new diffuseATF() );
			var normalMap:Texture2D = Texture2D.fromByteArray( new normalATF() ); // TODO add specular map
			
			var effect:DiffuseNormalSpecularEffect = new DiffuseNormalSpecularEffect( diffuseMap, normalMap, normalMap, light );
			
			var torus:TorusPrimitive = new TorusPrimitive( effect, true, true, true, true );
			
			scene.addChild( torus );
		}
	}
}