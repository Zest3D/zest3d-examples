package plugin.examples.lua
{
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.text.TextField;
	import io.plugin.core.graphics.Color;
	import io.plugin.utils.Stats;
	import luaAlchemy.LuaAlchemy;
	import zest3d.applications.Zest3DApplication;
	import zest3d.localeffects.FlatMaterialEffect;
	import zest3d.primitives.TorusPrimitive;
	import zest3d.scenegraph.Light;
	import zest3d.scenegraph.Material;
	
	/**
	 * A very simple and early Lua script example.
	 * TODO Evolve the Lua entity system
	 * 
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class LuaExample extends Zest3DApplication
	{
		private var _tf:TextField;
		
		[Embed(source = "../../../assets/lua/add_torus.lua", mimeType = "application/octet-stream")]
		private const addTorusLUA:Class;
		
		override protected function initialize():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			addChild( new Stats( 70, 0, 30 ) );
			clearColor = new Color( 0.3, 0.6, 0.9, 1 );
			
			includeLuaClassDependencies();
			
			var lua:LuaAlchemy = new LuaAlchemy();
			lua.setGlobal("scene", scene);
			lua.supplyFile("builtin://add_torus.lua", new addTorusLUA() );
			lua.doFileAsync("builtin://add_torus.lua", onParseComplete );
		}
		
		private function onParseComplete( arr:Array ):void
		{
			if ( arr[0] )
			{
				var list:Vector.<Object> = new Vector.<Object>();
				scene.getAllObjectsByName( "myTorus", list );
				trace( "Length: " + list.length );
			}
		}
		
		private function includeLuaClassDependencies():void
		{
			var light:Light;
			var material:Material;
			var color:Color;
			var effect:FlatMaterialEffect;
			var torus:TorusPrimitive;
		}
	}
}