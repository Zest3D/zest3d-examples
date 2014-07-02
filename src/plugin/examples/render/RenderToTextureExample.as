package plugin.examples.render 
{
	import plugin.core.graphics.Color;
	import plugin.core.interfaces.IDisposable;
	import zest3d.applications.Zest3DApplication;
	import zest3d.localeffects.TextureEffect;
	import zest3d.primitives.CubePrimitive;
	import zest3d.primitives.TorusPrimitive;
	import zest3d.resources.enum.AttributeType;
	import zest3d.resources.enum.AttributeUsageType;
	import zest3d.resources.enum.TextureFormat;
	import zest3d.resources.RenderTarget;
	import zest3d.resources.Texture2D;
	import zest3d.resources.VertexFormat;
	import zest3d.scenegraph.Camera;
	import zest3d.scenegraph.ScreenTarget;
	import zest3d.scenegraph.TriMesh;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class RenderToTextureExample extends Zest3DApplication implements IDisposable
	{
		
		private var _screenCamera:Camera;
		private var _renderTarget:RenderTarget;
		private var _screenPolygon:TriMesh;
		
		[Embed(source="../../../assets/atf/bw_checked.atf", mimeType="application/octet-stream")]
		private const CHECKED_ATF:Class;
		
		override protected function initialize():void 
		{
			
			// create a screen polygon
			var vFormat:VertexFormat = VertexFormat.create( 2,
											AttributeUsageType.POSITION, AttributeType.FLOAT3, 0,
											AttributeUsageType.TEXCOORD, AttributeType.FLOAT2, 0 );
			
			const rtWidth:int = 256;
			const rtHeight:int = 256;
			_screenPolygon = ScreenTarget.createRectangle(vFormat, rtWidth, rtHeight, 0, 0.2, 0, 0.2, 0 );
			
			// create a screen camera
			_screenCamera = ScreenTarget.createCamera();
			
			// create a render target with 1 texture
			//_renderTarget = new RenderTarget( 1, TextureFormat.RGBA8888, rtWidth, rtHeight, false, false );
			
			var effect:TextureEffect = new TextureEffect( Texture2D.fromATFData( new CHECKED_ATF() ) );
			var torus:TorusPrimitive = new TorusPrimitive( effect, true, false );
			scene.addChild( torus );
			
			/*
			var textureEffect:TextureEffect = new TextureEffect( _renderTarget.getColorTextureAt( 0 ) );
			scene.addChild( cube );
			*/
		}
		
		override public function onIdle():void 
		{
			measureTime();
			
			if (moveCamera())
			{
				_culler.computeVisibleSet( scene );
			}
			
			if ( moveObject())
			{
				scene.update();
				_culler.computeVisibleSet( scene );
			}
			
			if ( _renderer.preDraw() )
			{
				/*
				// Draw the scene to a render target.
				renderer.enableRenderTarget( _renderTarget );
				renderer.clearColor = new Color( 1, 1, 1, 1 );
				renderer.clearBuffers();
				renderer.drawVisibleSet( _culler.visibleSet );
				renderer.disableRenderTarget( _renderTarget );
				*/
				
				// Draw the scene to the main window and also to a regular screen
				// polygon, placed in the lower-left corner of the main window.
				//renderer.clearColor = new Color( 0.2, 0.2, 0.2, 1 );
				renderer.clearBuffers();
				renderer.drawVisibleSet( _culler.visibleSet );
				//renderer.camera = _screenCamera;
				//renderer.drawVisual( _screenPolygon );
				
				//renderer.camera = camera;
				renderer.postDraw();
				renderer.displayColorBuffer();
			}
		}
		
		override protected function update(appTime:Number):void 
		{
			super.update(appTime);
		}
	}

}