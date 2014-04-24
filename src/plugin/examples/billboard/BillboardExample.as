package plugin.examples.billboard 
{
	import flash.events.MouseEvent;
	import io.plugin.utils.Stats;
	import zest3d.applications.Zest3DApplication;
	import zest3d.detail.BillboardNode;
	import zest3d.localeffects.ReflectionEffect;
	import zest3d.localeffects.TextureEffect;
	import zest3d.geometry.SkyboxGeometry;
	import zest3d.primitives.PlanePrimitive;
	import zest3d.resources.Texture2D;
	import zest3d.resources.TextureCube;
	
	/**
	 * This BillboardNode example causes the torus mesh to orient to the camera. BillboardNodes preserve
	 * the world orientation UNIT_Y axis. Use WASD controls to move the camera.
	 * 
	 * @author Gary Paluk
	 */
	public class BillboardExample extends Zest3DApplication 
	{
		
		[Embed(source="../../../assets/atfcube/skybox.atf", mimeType="application/octet-stream")]
		private var SkyboxATF:Class;
		
		[Embed(source = "../../../assets/atf/bw_checked.atf", mimeType = "application/octet-stream")]
		private var CheckedATF:Class;
		
		override protected function initialize():void
		{
			addChild( new Stats() );
			
			var skyTexture:TextureCube = TextureCube.fromByteArray( new SkyboxATF() );
			var reflectionEffect:ReflectionEffect = new ReflectionEffect( skyTexture );
			skybox = new SkyboxGeometry( skyTexture );
			
			var checkedTexture:Texture2D = Texture2D.fromByteArray( new CheckedATF() );
			var texture2DEffect:TextureEffect = new TextureEffect( checkedTexture );
			var plane:PlanePrimitive = new PlanePrimitive( texture2DEffect, true, false );
			
			var billboard:BillboardNode = new BillboardNode( camera );
			billboard.addChild( plane );
			scene.addChild( billboard );
		}
		
		override protected function onMouseDown(e:MouseEvent):Boolean 
		{
			return false;
		}
	}
}