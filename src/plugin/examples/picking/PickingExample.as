package plugin.examples.picking 
{
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.getTimer;
	import io.plugin.core.graphics.Color;
	import zest3d.applications.Zest3DApplication;
	import zest3d.localeffects.PhongEffect;
	import zest3d.geometry.SkyboxGeometry;
	import zest3d.primitives.SpherePrimitive;
	import zest3d.primitives.TorusPrimitive;
	import zest3d.resources.Texture2D;
	import zest3d.resources.TextureCube;
	import zest3d.scenegraph.enum.CullingType;
	import zest3d.scenegraph.Light;
	import zest3d.scenegraph.LightNode;
	import zest3d.scenegraph.PickRecord;
	import zest3d.scenegraph.Spatial;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 * 
	 * FIXME - Known bug, childAt(0) bounds are not updating correctly.
	 */
	public class PickingExample extends Zest3DApplication 
	{
		[Embed(source = "../../../assets/atf/bw_checked.atf", mimeType = "application/octet-stream")]
		private const CHECKED_ATF:Class;
		
		[Embed(source="../../../assets/atfcube/rock_water.atf", mimeType="application/octet-stream")]
		private const SKYBOX_ATF:Class;
		
		private var _tf:TextField;
		
		private var _mesh1:TorusPrimitive;
		private var _mesh2:TorusPrimitive;
		private var _mesh3:TorusPrimitive;
		private var _mesh4:SpherePrimitive;
		
		override protected function initialize():void 
		{
			_tf = new TextField();
			_tf.textColor = 0xFFFFFF;
			_tf.width = stage.stageWidth;
			_tf.height = stage.stageHeight;
			_tf.selectable = false;
			addChild( _tf );
			
			var checkedTexture:Texture2D = Texture2D.fromByteArray( new CHECKED_ATF() );
			
			var light:Light = new Light();
			light.ambient = new Color( 0.05, 0.07, 0.2 );
			light.specular = new Color( 0.8, 0.9, 1 );
			light.exponent = 50;
			
			var lightNode:LightNode = new LightNode( light );
			lightNode.name = "light";
			lightNode.x = 1;
			lightNode.y = -5;
			lightNode.z = -5
			
			var phongEffect:PhongEffect = new PhongEffect( checkedTexture, light );
			skybox = new SkyboxGeometry( TextureCube.fromByteArray( new SKYBOX_ATF()) );
			skybox.name = "skybox";
			
			_mesh1 = new TorusPrimitive( phongEffect, true, true );
			_mesh1.culling = CullingType.NEVER;
			_mesh1.name = "Torus_1";
			
			_mesh2 = new TorusPrimitive( phongEffect, true, true );
			_mesh2.culling = CullingType.NEVER;
			_mesh2.name = "Torus_2";
			
			_mesh3 = new TorusPrimitive( phongEffect, true, true );
			_mesh3.culling = CullingType.NEVER;
			_mesh3.name = "Torus_3";
			
			_mesh4 = new SpherePrimitive( phongEffect, true, true );
			_mesh4.culling = CullingType.NEVER;
			_mesh4.name = "Sphere_1";
			
			scene.addChild( _mesh1 );
			scene.addChild( _mesh2 );
			scene.addChild( _mesh3 );
			scene.addChild( _mesh4 );
			
			_mesh1.translate( -2.5, -1.5, 0 );
			_mesh2.translate(  2.5, -1.5, 0 );
			_mesh3.translate(  2.5,  1.5, 0 );
			_mesh4.translate( -2.5,  1.5, 0 );
			
			scene.addChild( lightNode );
		}
		
		override protected function onMouseDown(e:MouseEvent):Boolean 
		{
			var x:Number = e.localX;
			var y:Number = e.localY;
			_height = renderer.height;
			
			var viewport:Array = renderer.getViewport();
			var time:uint = getTimer();
			
			if ( _renderer.getPickRay( x, _height - 1 - y, _pickOrigin, _pickDirection ) )
			{
				_picker.execute( scene, _pickOrigin, _pickDirection, 0, Number.MAX_VALUE);
				
				if (_picker.records.length > 0)
				{
					var record:PickRecord = _picker.closestNonNegative;
					var object:Spatial = record.intersected;
					
					_tf.text = "Pick Records: " + _picker.records.length + "\nx: " + x + "\nheight: " + _height + "\norigin: " + _pickOrigin + "\ndirection: " + _pickDirection;
					
					
					for ( var i:int = 0; i < _picker.records.length; ++i )
					{
						_tf.appendText( "\n" );
						_tf.appendText( "\n=== Pick record " + i + " ===" );
						_tf.appendText( "\nRay t distance: " + _picker.records[i].t );
						_tf.appendText( "\nMesh polygon ID: " + _picker.records[i].triangle );
						_tf.appendText( "\nBarycentric coords: " + _picker.records[i].bary );
						_tf.appendText( "\nIntersected Mesh: " + _picker.records[i].intersected.name );
						
						_tf.appendText( "\n" );
					}
				}
				else
				{
					_tf.text = "Pick Records: 0\nx: " + x + "\nheight: " + (_height - 1) + "\norigin: " + _pickOrigin + "\ndirection: " + _pickDirection;
				}
				_tf.appendText( "\nTotal Time ms: " + (getTimer() - time) );
			}
			return super.onMouseDown(e);
		}
		
		override public function onResize(width:int, height:int):void 
		{
			_tf.width = stage.stageWidth;
			_tf.height = stage.stageHeight;
			super.onResize(width, height);
		}
		
	}

}