package plugin.examples.effects 
{
	import flash.events.MouseEvent;
	import io.plugin.core.graphics.Color;
	import io.plugin.math.algebra.APoint;
	import io.plugin.utils.Stats;
	import plugin.net.parsers.max3ds.ParserAdapter3DS;
	import zest3d.applications.Zest3DApplication;
	import zest3d.localeffects.DiffuseNormalSpecularEffect;
	import zest3d.geometry.SkyboxGeometry;
	import zest3d.primitives.TorusPrimitive;
	import zest3d.resources.Texture2D;
	import zest3d.resources.TextureCube;
	import zest3d.scenegraph.enum.UpdateType;
	import zest3d.scenegraph.Light;
	import zest3d.scenegraph.LightNode;
	import zest3d.scenegraph.Node;
	import zest3d.scenegraph.TriMesh;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class DiffuseNormalSpecularEffect3DSExample extends Zest3DApplication
	{
		
		[Embed(source = "../../../assets/atfcube/rock_water.atf", mimeType = "application/octet-stream")]
		private const skyboxATF:Class;
		
		[Embed(source = "../../../assets/atf/witcher/Eye_Diff.atf", mimeType = "application/octet-stream")]
		private const eyeDiffATF:Class;
		
		[Embed(source = "../../../assets/atf/witcher/Eye_Norm.atf", mimeType = "application/octet-stream")]
		private const eyeNormATF:Class;
		
		[Embed(source = "../../../assets/atf/witcher/Eyelashes_Diff.atf", mimeType = "application/octet-stream")]
		private const eyelashDiffATF:Class;
		
		[Embed(source = "../../../assets/atf/witcher/Eyelashes_Norm.atf", mimeType = "application/octet-stream")]
		private const eyelashNormATF:Class;
		
		[Embed(source = "../../../assets/atf/witcher/Hair_Diff.atf", mimeType = "application/octet-stream")]
		private const hairDiffATF:Class;
		
		[Embed(source = "../../../assets/atf/witcher/Hair_Norm.atf", mimeType = "application/octet-stream")]
		private const hairNormATF:Class;
		
		[Embed(source = "../../../assets/atf/witcher/Mouth_Diff.atf", mimeType = "application/octet-stream")]
		private const mouthDiffATF:Class;
		
		[Embed(source = "../../../assets/atf/witcher/Mouth_Norm.atf", mimeType = "application/octet-stream")]
		private const mouthNormATF:Class;
		
		[Embed(source = "../../../assets/atf/witcher/Ves_Diff.atf", mimeType = "application/octet-stream")]
		private const vesMainDiffATF:Class;
		
		[Embed(source = "../../../assets/atf/witcher/Ves_Norm.atf", mimeType = "application/octet-stream")]
		private const vesMainNormATF:Class;
		
		[Embed(source = "../../../assets/3ds/witcher.3ds", mimeType = "application/octet-stream")]
		private const ff3DS:Class;
		
		private var _model:Node;
		
		override protected function initialize():void 
		{
			camera.position = new APoint( 0, -1, -1.5 );
			
			addChild( new Stats() );
			
			skybox = new SkyboxGeometry( TextureCube.fromByteArray( new skyboxATF() ) );
			
			var light:Light = new Light();
			light.position = new APoint( 100, -50, -100 );
			light.ambient = new Color( 0.4, 0.4, 0.5 );
			light.specular = new Color( 0.4, 0.4, 0.55 );
			light.exponent = 50;
			
			var light2:Light = new Light();
			light2.position = new APoint( 100, -50, -100 );
			light2.ambient = new Color( 0.4, 0.4, 0.5 );
			light2.specular = new Color( 0.1, 0.1, 0.15 );
			light2.exponent = 5;
			
			var light3:Light = new Light();
			light3.position = new APoint( 100, -50, -100 );
			light3.ambient = new Color( 0.4, 0.4, 0.5 );
			light3.specular = new Color( 0.2, 0.2, 0.25 );
			light3.exponent = 500;
			
			var parserAdapter:ParserAdapter3DS = new ParserAdapter3DS( new ff3DS(), true, true, true, true );
			parserAdapter.parse();
			
			var eyeDiffuse:Texture2D = Texture2D.fromByteArray( new eyeDiffATF() );
			var eyeNormal:Texture2D = Texture2D.fromByteArray( new eyeNormATF() );
			var eyeEffect:DiffuseNormalSpecularEffect = new DiffuseNormalSpecularEffect( eyeDiffuse, eyeNormal, eyeNormal, light );
			
			var eyelashDiffuse:Texture2D = Texture2D.fromByteArray( new eyelashDiffATF() );
			var eyelashNormal:Texture2D = Texture2D.fromByteArray( new eyelashNormATF() );
			var eyelashEffect:DiffuseNormalSpecularEffect = new DiffuseNormalSpecularEffect( eyelashDiffuse, eyelashNormal, eyeNormal, light );
			
			var mouthDiffuse:Texture2D = Texture2D.fromByteArray( new mouthDiffATF() );
			var mouthNormal:Texture2D = Texture2D.fromByteArray( new mouthNormATF() );
			var mouthEffect:DiffuseNormalSpecularEffect = new DiffuseNormalSpecularEffect( mouthDiffuse, mouthNormal, eyeNormal, light );
			
			var hairDiffuse:Texture2D = Texture2D.fromByteArray( new hairDiffATF() );
			var hairNormal:Texture2D = Texture2D.fromByteArray( new hairNormATF() );
			var hairEffect:DiffuseNormalSpecularEffect = new DiffuseNormalSpecularEffect( hairDiffuse, hairNormal, eyeNormal, light3 );
			
			var vesDiffuse:Texture2D = Texture2D.fromByteArray( new vesMainDiffATF() );
			var vesNormal:Texture2D = Texture2D.fromByteArray( new vesMainNormATF() );
			var vesEffect:DiffuseNormalSpecularEffect = new DiffuseNormalSpecularEffect( vesDiffuse, vesNormal, eyeNormal, light );
			
			var skinEffect:DiffuseNormalSpecularEffect = new DiffuseNormalSpecularEffect( vesDiffuse, vesNormal, eyeNormal, light2 );
			
			
			_model = new Node();
			
			var mesh:TriMesh;
			
			// 0 eyelashes
			mesh = parserAdapter.getMeshAt( 0 );
			mesh.effect = eyelashEffect;
			_model.addChild( mesh );
			
			// 1 tag
			mesh = parserAdapter.getMeshAt( 1 );
			mesh.effect = vesEffect;
			_model.addChild( mesh );
			
			// 2 head
			mesh = parserAdapter.getMeshAt( 2 );
			mesh.effect = skinEffect;
			_model.addChild( mesh );
			
			// 3 clothes
			mesh = parserAdapter.getMeshAt( 3 );
			mesh.effect = vesEffect;
			_model.addChild( mesh );
			
			// 4 armor
			mesh = parserAdapter.getMeshAt( 4 );
			mesh.effect = vesEffect;
			_model.addChild( mesh );
			
			// 5 eyes
			mesh = parserAdapter.getMeshAt( 5 );
			mesh.effect = eyeEffect;
			_model.addChild( mesh );
			
			// 6 skin
			mesh = parserAdapter.getMeshAt( 6 );
			mesh.effect = skinEffect;
			_model.addChild( mesh );
			
			// 7 hair
			mesh = parserAdapter.getMeshAt( 7 );
			mesh.effect = hairEffect;
			_model.addChild( mesh );
			
			// 8 leather
			mesh = parserAdapter.getMeshAt( 8 );
			mesh.effect = vesEffect;
			_model.addChild( mesh );
			
			// 9 mouth
			mesh = parserAdapter.getMeshAt( 9 );
			mesh.effect = mouthEffect;
			_model.addChild( mesh );
			
			// 10 gauntlet
			mesh = parserAdapter.getMeshAt( 10 );
			mesh.effect = vesEffect;
			_model.addChild( mesh );
			
			scene.addChild( _model );
		}
		
		override protected function update(appTime:Number):void 
		{
			_model.rotationY = appTime * 0.0005;
			super.update(appTime);
		}
		
		override protected function onMouseDown(e:MouseEvent):Boolean 
		{
			return false;
		}
	}
}