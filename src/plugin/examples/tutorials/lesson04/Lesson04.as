package plugin.examples.tutorials.lesson04 
{
	import flash.events.MouseEvent;
	import zest3d.applications.Zest3DApplication;
	import zest3d.detail.BillboardNode;
	import zest3d.localeffects.ReflectionEffect;
	import zest3d.localeffects.TextureEffect;
	import zest3d.geometry.SkyboxGeometry;
	import zest3d.primitives.PlanePrimitive;
	import zest3d.resources.Texture2D;
	import zest3d.resources.TextureCube;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class Lesson04 extends Zest3DApplication 
	{
		[Embed(source="../../../../assets/atfcube/skybox.atf", mimeType="application/octet-stream")]
		private var SKYBOX_ATF:Class;
		
		[Embed(source = "../../../../assets/atf/bw_checked.atf", mimeType = "application/octet-stream")]
		private var CHECKED_ATF:Class;
		
		override protected function initialize():void 
		{
			var skyTexture:TextureCube = TextureCube.fromByteArray( new SKYBOX_ATF() );
			var reflectionEffect:ReflectionEffect = new ReflectionEffect( skyTexture );
			skybox = new SkyboxGeometry( skyTexture );
			
			var checkedTexture:Texture2D = Texture2D.fromByteArray( new CHECKED_ATF() );
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