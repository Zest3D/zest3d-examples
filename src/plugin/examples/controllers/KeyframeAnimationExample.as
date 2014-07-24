package plugin.examples.controllers 
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import flash.utils.getTimer;
	import plugin.core.system.Assert;
	import plugin.math.algebra.APoint;
	import plugin.math.algebra.HMatrix;
	import plugin.math.algebra.HQuaternion;
	import plugin.utils.Stats;
	import zest3d.applications.Zest3DApplication;
	import zest3d.controllers.enum.RepeatType;
	import zest3d.controllers.KeyframeController;
	import zest3d.controllers.SkinController;
	import zest3d.datatypes.Transform;
	import zest3d.localeffects.ReflectionEffect;
	import zest3d.resources.enum.AttributeType;
	import zest3d.resources.enum.AttributeUsageType;
	import zest3d.resources.IndexBuffer;
	import zest3d.resources.TextureCube;
	import zest3d.resources.VertexBuffer;
	import zest3d.resources.VertexFormat;
	import zest3d.scenegraph.Material;
	import zest3d.scenegraph.Node;
	import zest3d.scenegraph.TriMesh;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class KeyframeAnimationExample extends Zest3DApplication//Game //implements IDisposable 
	{
		
		[Embed(source="../../../assets/atfcube/skybox.atf", mimeType="application/octet-stream")]
		private const SKYBOX_ATF: Class;
		
		[Embed(source="../../../assets/biped/SkinnedBipedPN.be.wmof", mimeType="application/octet-stream")]
		private const Biped: Class;
		
		private var _animTime: Number = 0.0;
		private var _animTimeDelta: Number = 0.3;
		
		protected var _vFormat: VertexFormat;
		
		//{ Keyframe data
		[Embed(source="../../../assets/biped/Data/Biped.keyf.raw", mimeType="application/octet-stream")]
		private var BIPED: Class;
		
		[Embed(source = "../../../assets/biped/Data/Pelvis.keyf.raw", mimeType = "application/octet-stream")]
		private var PELVIS: Class;
		
		[Embed(source = "../../../assets/biped/Data/Spine.keyf.raw", mimeType = "application/octet-stream")]
		private var SPINE: Class;
		
		[Embed(source = "../../../assets/biped/Data/Spine1.keyf.raw", mimeType = "application/octet-stream")]
		private var SPINE_1: Class;
		
		[Embed(source = "../../../assets/biped/Data/Spine2.keyf.raw", mimeType = "application/octet-stream")]
		private var SPINE_2: Class;
		
		[Embed(source = "../../../assets/biped/Data/Spine3.keyf.raw", mimeType = "application/octet-stream")]
		private var SPINE_3: Class;
		
		[Embed(source = "../../../assets/biped/Data/Neck.keyf.raw", mimeType = "application/octet-stream")]
		private var NECK: Class;
		
		[Embed(source = "../../../assets/biped/Data/Head.keyf.raw", mimeType = "application/octet-stream")]
		private var HEAD: Class;
		
		[Embed(source = "../../../assets/biped/Data/L_Clavicle.keyf.raw", mimeType = "application/octet-stream")]
		private var L_CLAVICLE: Class;
		
		[Embed(source = "../../../assets/biped/Data/L_UpperArm.keyf.raw", mimeType = "application/octet-stream")]
		private var L_UPPERARM: Class;
		
		[Embed(source = "../../../assets/biped/Data/L_Forearm.keyf.raw", mimeType = "application/octet-stream")]
		private var L_FOREARM: Class;
		
		[Embed(source = "../../../assets/biped/Data/L_Hand.keyf.raw", mimeType = "application/octet-stream")]
		private var L_HAND: Class;
		
		[Embed(source = "../../../assets/biped/Data/R_Clavicle.keyf.raw", mimeType = "application/octet-stream")]
		private var R_CLAVICLE: Class;
		
		[Embed(source = "../../../assets/biped/Data/R_UpperArm.keyf.raw", mimeType = "application/octet-stream")]
		private var R_UPPERARM: Class;
		
		[Embed(source = "../../../assets/biped/Data/R_Forearm.keyf.raw", mimeType = "application/octet-stream")]
		private var R_FOREARM: Class;
		
		[Embed(source = "../../../assets/biped/Data/R_Hand.keyf.raw", mimeType = "application/octet-stream")]
		private var R_HAND: Class;
		
		[Embed(source = "../../../assets/biped/Data/L_Thigh.keyf.raw", mimeType = "application/octet-stream")]
		private var L_THIGH: Class;
		
		[Embed(source = "../../../assets/biped/Data/L_Calf.keyf.raw", mimeType = "application/octet-stream")]
		private var L_CALF: Class;
		
		[Embed(source = "../../../assets/biped/Data/L_Foot.keyf.raw", mimeType = "application/octet-stream")]
		private var L_FOOT: Class;
		
		[Embed(source = "../../../assets/biped/Data/L_Toe.keyf.raw", mimeType = "application/octet-stream")]
		private var L_TOE: Class;
		
		[Embed(source = "../../../assets/biped/Data/R_Thigh.keyf.raw", mimeType = "application/octet-stream")]
		private var R_THIGH: Class;
		
		[Embed(source = "../../../assets/biped/Data/R_Calf.keyf.raw", mimeType = "application/octet-stream")]
		private var R_CALF: Class;
		
		[Embed(source = "../../../assets/biped/Data/R_Foot.keyf.raw", mimeType = "application/octet-stream")]
		private var R_FOOT: Class;
		
		[Embed(source = "../../../assets/biped/Data/R_Toe.keyf.raw", mimeType = "application/octet-stream")]
		private var R_TOE: Class;
		
		//}
		
		//{ Mesh data
		[Embed(source = "../../../assets/biped/Data/Hair.triangle.raw", mimeType = "application/octet-stream")]
		private var HAIR_MESH: Class;
		
		[Embed(source = "../../../assets/biped/Data/L_Arm.triangle.raw", mimeType = "application/octet-stream")]
		private var L_ARM_MESH: Class;
		
		[Embed(source = "../../../assets/biped/Data/R_Arm.triangle.raw", mimeType = "application/octet-stream")]
		private var R_ARM_MESH: Class;
		
		[Embed(source = "../../../assets/biped/Data/Face.triangle.raw", mimeType = "application/octet-stream")]
		private var FACE_MESH: Class;
		
		[Embed(source = "../../../assets/biped/Data/L_Shoe.triangle.raw", mimeType = "application/octet-stream")]
		private var L_SHOE_MESH: Class;
		
		[Embed(source = "../../../assets/biped/Data/L_Leg.triangle.raw", mimeType = "application/octet-stream")]
		private var L_LEG_MESH: Class;
		
		[Embed(source = "../../../assets/biped/Data/L_Ankle.triangle.raw", mimeType = "application/octet-stream")]
		private var L_ANKLE_MESH: Class;
		
		[Embed(source = "../../../assets/biped/Data/R_Shoe.triangle.raw", mimeType = "application/octet-stream")]
		private var R_SHOE_MESH: Class;
		
		[Embed(source = "../../../assets/biped/Data/R_Leg.triangle.raw", mimeType = "application/octet-stream")]
		private var R_LEG_MESH: Class;
		
		[Embed(source = "../../../assets/biped/Data/R_Ankle.triangle.raw", mimeType = "application/octet-stream")]
		private var R_ANKLE_MESH: Class;
		
		[Embed(source = "../../../assets/biped/Data/Shirt.triangle.raw", mimeType = "application/octet-stream")]
		private var SHIRT_MESH: Class;
		
		[Embed(source = "../../../assets/biped/Data/Pants.triangle.raw", mimeType = "application/octet-stream")]
		private var PANTS_MESH: Class;
		//}
		
		//{ Skin data
		[Embed(source = "../../../assets/biped/Data/Hair.skin.raw", mimeType = "application/octet-stream")]
		private var HAIR_SKIN: Class;
		
		[Embed(source = "../../../assets/biped/Data/L_Arm.skin.raw", mimeType = "application/octet-stream")]
		private var L_ARM_SKIN: Class;
		
		[Embed(source = "../../../assets/biped/Data/R_Arm.skin.raw", mimeType = "application/octet-stream")]
		private var R_ARM_SKIN: Class;
		
		[Embed(source = "../../../assets/biped/Data/Face.skin.raw", mimeType = "application/octet-stream")]
		private var FACE_SKIN: Class;
		
		[Embed(source = "../../../assets/biped/Data/L_Shoe.skin.raw", mimeType = "application/octet-stream")]
		private var L_SHOE_SKIN: Class;
		
		[Embed(source = "../../../assets/biped/Data/L_Leg.skin.raw", mimeType = "application/octet-stream")]
		private var L_LEG_SKIN: Class;
		
		[Embed(source = "../../../assets/biped/Data/L_Ankle.skin.raw", mimeType = "application/octet-stream")]
		private var L_ANKLE_SKIN: Class;
		
		[Embed(source = "../../../assets/biped/Data/R_Shoe.skin.raw", mimeType = "application/octet-stream")]
		private var R_SHOE_SKIN: Class;
		
		[Embed(source = "../../../assets/biped/Data/R_Leg.skin.raw", mimeType = "application/octet-stream")]
		private var R_LEG_SKIN: Class;
		
		[Embed(source = "../../../assets/biped/Data/R_Ankle.skin.raw", mimeType = "application/octet-stream")]
		private var R_ANKLE_SKIN: Class;
		
		[Embed(source = "../../../assets/biped/Data/Shirt.skin.raw", mimeType = "application/octet-stream")]
		private var SHIRT_SKIN: Class;
		
		[Embed(source = "../../../assets/biped/Data/Pants.skin.raw", mimeType = "application/octet-stream")]
		private var PANTS_SKIN: Class;
		//}
		
		override protected function initialize():void 
		{
			//clearColor = new Color( 0, 0, 0, 0 );
			var stats: Stats = new Stats();
			addChild( stats );
			_camera.position = new APoint( 0, -20, -80 );
			
			_vFormat = VertexFormat.create( 2, AttributeUsageType.POSITION, AttributeType.FLOAT3, 0,
											   AttributeUsageType.NORMAL, AttributeType.FLOAT3, 0 );
			
			createScene();
			
			initializeCameraMotion( 1, .1, 1, 1 );
		}
		
		private function createScene(): void
		{
			var biped: Node = getNode( "Biped", new BIPED() );
			var pelvis: Node = getNode( "Pelvis", new PELVIS() );
			var spine: Node = getNode( "Spine", new SPINE() );
			var spine1: Node = getNode( "Spine1", new SPINE_1() );
			var spine2: Node = getNode( "Spine2", new SPINE_2() );
			var spine3: Node = getNode( "Spine3", new SPINE_3() );
			var neck: Node = getNode( "Neck", new NECK() );
			var head: Node = getNode( "Head", new HEAD() );
			var leftClavicle: Node = getNode( "L_Clavicle", new L_CLAVICLE() );
			var leftUpperArm: Node = getNode( "L_UpperArm", new L_UPPERARM() );
			var leftForeArm : Node = getNode( "L_Forearm", new L_FOREARM() );
			var leftHand: Node = getNode( "L_Hand", new L_HAND() );
			var rightClavicle: Node = getNode( "R_Clavicle", new R_CLAVICLE() );
			var rightUpperArm: Node = getNode( "R_UpperArm", new R_UPPERARM() );
			var rightForeArm: Node = getNode( "R_Forearm", new R_FOREARM() );
			var rightHand: Node = getNode( "R_Hand", new R_HAND() );
			var leftThigh: Node = getNode( "L_Thigh", new L_THIGH() );
			var leftCalf: Node = getNode( "L_Calf", new L_CALF() );
			var leftFoot: Node = getNode( "L_Foot", new L_FOOT() );
			var leftToe: Node = getNode( "L_Toe", new L_TOE() );
			var rightThigh: Node = getNode( "R_Thigh", new R_THIGH() );
			var rightCalf: Node = getNode( "R_Calf", new R_CALF() );
			var rightFoot: Node = getNode( "R_Foot", new R_FOOT() );
			var rightToe: Node = getNode( "R_Toe", new R_TOE() );
			
			biped.addChild( pelvis );
				pelvis.addChild( spine );
					spine.addChild( spine1 );
						spine1.addChild( spine2 );
							spine2.addChild( spine3 );
								spine3.addChild( neck );
									neck.addChild( head );
									neck.addChild( leftClavicle );
										leftClavicle.addChild( leftUpperArm );
											leftUpperArm.addChild( leftForeArm );
												leftForeArm.addChild( leftHand );
									neck.addChild( rightClavicle );
										rightClavicle.addChild( rightUpperArm );
											rightUpperArm.addChild( rightForeArm );
												rightForeArm.addChild( rightHand );
				pelvis.addChild( leftThigh );
					leftThigh.addChild( leftCalf );
						leftCalf.addChild( leftFoot );
							leftFoot.addChild( leftToe );
				pelvis.addChild( rightThigh );
					rightThigh.addChild( rightCalf );
						rightCalf.addChild( rightFoot );
							rightFoot.addChild( rightToe );
			
			var hair: TriMesh = getMesh( "Hair", new HAIR_MESH(), new HAIR_SKIN(), biped );
			var leftArm: TriMesh = getMesh( "L_Arm", new L_ARM_MESH(), new L_ARM_SKIN(), biped );
			var rightArm: TriMesh = getMesh( "R_Arm", new R_ARM_MESH(), new R_ARM_SKIN(), biped );
			var face: TriMesh = getMesh( "Face", new FACE_MESH(), new FACE_SKIN(), biped );
			var leftShoe: TriMesh = getMesh( "L_Shoe", new L_SHOE_MESH(), new L_SHOE_SKIN(), biped );
			var leftLeg: TriMesh = getMesh( "L_Leg", new L_LEG_MESH(), new L_LEG_SKIN(), biped );
			var leftAnkle: TriMesh = getMesh( "L_Ankle", new L_ANKLE_MESH(), new L_ANKLE_SKIN(), biped );
			var rightShoe: TriMesh = getMesh( "R_Shoe", new R_SHOE_MESH(), new R_SHOE_SKIN(), biped );
			var rightLeg: TriMesh = getMesh( "R_Leg", new R_LEG_MESH(), new R_LEG_SKIN(), biped );
			var rightAnkle: TriMesh = getMesh( "R_Ankle", new R_ANKLE_MESH(), new R_ANKLE_SKIN(), biped );
			var shirt: TriMesh = getMesh( "Shirt", new SHIRT_MESH(), new SHIRT_SKIN(), biped );
			var pants: TriMesh = getMesh( "Pants", new PANTS_MESH(), new PANTS_SKIN(), biped );
			
			head.addChild( hair );
			leftUpperArm.addChild( leftArm );
			rightUpperArm.addChild( rightArm );
			spine3.addChild( face );
			leftCalf.addChild( leftShoe );
			leftThigh.addChild( leftLeg );
			leftThigh.addChild( leftAnkle );
			rightCalf.addChild( rightShoe );
			rightThigh.addChild( rightLeg );
			rightThigh.addChild( rightAnkle );
			pelvis.addChild( shirt );
			pelvis.addChild( pants );
			
			biped.rotationY = 90 * Math.PI / 180;
			biped.update(0);
			scene.addChild( biped );
			scene.update();
		}
		
		private function getNode( name: String, keyframeData: ByteArray ): Node
		{
			
			var node: Node = new Node();
			node.name = name;
			
			keyframeData.endian = Endian.LITTLE_ENDIAN;
			keyframeData.position = 0;
			var repeat: int = int( keyframeData.readFloat() );
			var minTime: Number = keyframeData.readFloat();
			var maxTime: Number = keyframeData.readFloat();
			var phase: Number = keyframeData.readFloat();
			var frequency: Number = keyframeData.readFloat();
			
			var numTranslations: int = keyframeData.readInt();
			var numRotations: int = keyframeData.readInt();
			var numScales: int = keyframeData.readInt();
			
			var i: int;
			var j: int;
			
			var keyframeController: KeyframeController = new KeyframeController( 0, numTranslations, numRotations, numScales, Transform.IDENTITY );
			var repeatType: RepeatType;
			switch( repeat )
			{
				case 0:
						repeatType = RepeatType.CLAMP;
					break;
				case 1:
						repeatType = RepeatType.WRAP;
					break;
				case 2:
						repeatType = RepeatType.CYCLE;
					break;
			}
			
			keyframeController.repeat = RepeatType.WRAP; // TODO remove hard coding
			keyframeController.minTime = minTime;
			keyframeController.maxTime = maxTime;
			keyframeController.phase = phase;
			keyframeController.frequency = frequency;
			
			if ( numTranslations > 0 )
			{
				var translationTimes: Array = keyframeController.translationTimes;
				var translations: Vector.<APoint> = keyframeController.translations;
				for ( i = 0; i < numTranslations; ++i )
				{
					translationTimes[ i ] = keyframeData.readFloat();
				}
				for ( i = 0; i < numTranslations; ++i )
				{
					translations[ i ].x = keyframeData.readFloat();
					translations[ i ].y = keyframeData.readFloat();
					translations[ i ].z = keyframeData.readFloat();
					// w = 1 by default as afine
				}
			}
			else
			{
				var translate: APoint = new APoint();
				translate.x = keyframeData.readFloat();
				translate.y = keyframeData.readFloat();
				translate.z = keyframeData.readFloat();
				node.localTransform.translate = translate;
			}
			
			if ( numRotations > 0 )
			{
				var rotationTimes: Array = keyframeController.rotationTimes;
				var rotations: Vector.<HQuaternion> = keyframeController.rotations;
				for ( i = 0; i < numRotations; ++i )
				{
					rotationTimes[ i ] = keyframeData.readFloat();
				}
				for ( i = 0; i < numRotations; ++i )
				{
					rotations[ i ].w = keyframeData.readFloat();
					rotations[ i ].x = keyframeData.readFloat();
					rotations[ i ].y = keyframeData.readFloat();
					rotations[ i ].z = keyframeData.readFloat();
				}
			}
			else
			{
				var rotate: HMatrix = new HMatrix
				(
					keyframeData.readFloat(),
					keyframeData.readFloat(),
					keyframeData.readFloat(),
					0,
					keyframeData.readFloat(),
					keyframeData.readFloat(),
					keyframeData.readFloat(),
					0,
					keyframeData.readFloat(),
					keyframeData.readFloat(),
					keyframeData.readFloat(),
					0,
					0, 0, 0, 1
				)
				node.localTransform.rotate = rotate;
			}
			
			if ( numScales > 0 )
			{
				var scaleTimes: Array = keyframeController.scaleTimes;
				var scales: Vector.<Number> = keyframeController.scales;
				
				for ( i = 0; i < numScales; ++i )
				{
					scaleTimes[ i ] = keyframeData.readFloat();
				}
				for ( i = 0; i < numScales; ++i )
				{
					scales[ i ] = keyframeData.readFloat();
				}
			}
			else
			{
				var scale: Number = keyframeData.readFloat();
				node.localTransform.uniformScale = scale;
			}
			
			Assert.isTrue( keyframeData.position == keyframeData.length, "The keyframe data pointer should be at the end of the file." );
			
			keyframeController.transform = node.localTransform;
			node.addController( keyframeController );
			
			return node;
		}
		
		public function getMesh( name: String, meshData: ByteArray, skinData: ByteArray, biped: Node ): TriMesh
		{
			
			// bone data /////////////////////////////////////////////////////////////////////////////////////////////////////////
			meshData.position = 0;
			meshData.endian = Endian.LITTLE_ENDIAN;
			
			var numTriangles: int = meshData.readInt();
			var numIndices: int = 3 * numTriangles;
			var iBuffer: IndexBuffer = new IndexBuffer( numIndices, 2 );
			
			var i: int;
			var j: int;
			
			var indices: ByteArray = iBuffer.data;
			indices.position = 0;
			for ( i = 0; i < numIndices; ++i )
			{
				indices.writeShort( meshData.readInt() );
			}
			
			var material: Material = new Material();
			material.emissive.r = meshData.readFloat();
			material.emissive.g = meshData.readFloat();
			material.emissive.b = meshData.readFloat();
			material.emissive.a = 1;
			
			material.ambient.r = meshData.readFloat();
			material.ambient.g = meshData.readFloat();
			material.ambient.b = meshData.readFloat();
			material.ambient.a = 1;
			
			material.diffuse.r = meshData.readFloat();
			material.diffuse.g = meshData.readFloat();
			material.diffuse.b = meshData.readFloat();
			material.diffuse.a = 1;
			
			material.specular.r = meshData.readFloat();
			material.specular.g = meshData.readFloat();
			material.specular.b = meshData.readFloat();
			material.specular.a = 0;
			
			
			
			// skin data /////////////////////////////////////////////////////////////////////////////////////////////////////////
			
			skinData.position = 0;
			skinData.endian = Endian.LITTLE_ENDIAN;
			
			var repeat: int = int( skinData.readFloat() );
			var minTime: Number = skinData.readFloat();
			var maxTime: Number = skinData.readFloat();
			var phase: Number = skinData.readFloat();
			var frequency: Number = skinData.readFloat();
			
			var numVertices: int =  skinData.readInt();
			var numBones: int = skinData.readInt();
			
			var skinController: SkinController = new SkinController( numVertices, numBones );
			
			var repeatType: RepeatType;
			switch( repeat )
			{
				case 0 :
						repeatType = RepeatType.CLAMP;
					break;
				case 1 :
						repeatType = RepeatType.CYCLE;
					break;
				case 2 :
						repeatType = RepeatType.WRAP;
					break;
			}
			
			skinController.minTime = minTime;
			skinController.maxTime = maxTime;
			skinController.phase = phase;
			skinController.frequency = frequency;
			
			var bones: Vector.<Node> = skinController.bones;
			for ( i = 0; i < numBones; ++i )
			{
				var length: int = skinData.readInt();
				var boneName: String = skinData.readUTFBytes( length );
				
				bones[ i ] = biped.getObjectByName( boneName ) as Node;
				Assert.isTrue( bones[i] != null, "Failed to find the bone: " + boneName );
			}
			
			var weights: Array = skinController.weights;
			var offsets: Array = skinController.offsets;
			
			for ( j = 0; j < numVertices; ++j )
			{
				for( i = 0; i < numBones; ++i )
				{
					weights[j][i] = skinData.readFloat();
					var offset: APoint = offsets[j][i];
					offset.x = skinData.readFloat();
					offset.y = skinData.readFloat();
					offset.z = skinData.readFloat();
				}
			}
			
			// check that we read everything
			Assert.isTrue( skinData.position == skinData.length, "The skin data pointer should be at the end of the file." );
			
			var stride: int = _vFormat.stride;
			var vBuffer: VertexBuffer = new VertexBuffer( numVertices, stride );
			
			var mesh: TriMesh = new TriMesh( _vFormat, vBuffer, iBuffer );
			mesh.name = name;
			mesh.addController( skinController );
			
			var texture: TextureCube = TextureCube.fromATFData( new SKYBOX_ATF() );
			mesh.effect = new ReflectionEffect( texture );
			
			return mesh;
		}
		
		override protected function update(appTime:Number):void 
		{
			_animTime += _animTimeDelta;
			_culler.computeVisibleSet( scene );
			scene.update( _animTime );
		}
		
	}
 
}