local light = as3.class.zest3d.scenegraph.Light.new()
local material = as3.class.zest3d.scenegraph.Material.new()
material.ambient = as3.class.plugin.core.graphics.Color.new(0.4, 0.2, 0.2, 1.0)
local effect = as3.class.zest3d.localeffects.ColorMaterialEffect.new(material)
local torus = as3.class.zest3d.primitives.TorusPrimitive.new(effect,false,false)
torus.name = "myTorus"
scene.addChild(torus)