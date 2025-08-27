components {
  id: "base_puller"
  component: "/scripts/base_puller.script"
}
embedded_components {
  id: "collisionobject"
  type: "collisionobject"
  data: "type: COLLISION_OBJECT_TYPE_KINEMATIC\n"
  "mass: 0.0\n"
  "friction: 0.1\n"
  "restitution: 0.5\n"
  "group: \"pull\"\n"
  "mask: \"particle\"\n"
  "embedded_collision_shape {\n"
  "  shapes {\n"
  "    shape_type: TYPE_BOX\n"
  "    position {\n"
  "    }\n"
  "    rotation {\n"
  "    }\n"
  "    index: 0\n"
  "    count: 3\n"
  "    id: \"shape\"\n"
  "  }\n"
  "  data: 0.5\n"
  "  data: 0.5\n"
  "  data: 0.5\n"
  "}\n"
  "bullet: true\n"
  ""
}
embedded_components {
  id: "model"
  type: "model"
  data: "mesh: \"/assets/models/arrow/arrow.glb\"\n"
  "name: \"{{NAME}}\"\n"
  "materials {\n"
  "  name: \"Material.001\"\n"
  "  material: \"/assets/models/arrow/arrow.material\"\n"
  "  textures {\n"
  "    sampler: \"tex0\"\n"
  "    texture: \"/assets/models/sphere/Noise.png\"\n"
  "  }\n"
  "}\n"
  ""
  rotation {
    x: 0.70710677
    w: 0.70710677
  }
}
embedded_components {
  id: "sprite_outline"
  type: "sprite"
  data: "default_animation: \"arrow_outline\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/textures/main_atlas.atlas\"\n"
  "}\n"
  ""
  position {
    x: -0.015
    y: -0.032
  }
  scale {
    x: 5.3E-4
    y: 6.8E-4
    z: 7.0E-4
  }
}
embedded_components {
  id: "sprite_fill"
  type: "sprite"
  data: "default_animation: \"arrow\"\n"
  "material: \"/assets/models/arrow/arrow_fill.material\"\n"
  "size {\n"
  "  x: 1200.0\n"
  "  y: 1200.0\n"
  "}\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/textures/main_atlas.atlas\"\n"
  "}\n"
  "textures {\n"
  "  sampler: \"tex0\"\n"
  "  texture: \"/assets/textures/noise.atlas\"\n"
  "}\n"
  ""
  position {
    x: -0.015
    y: -0.032
    z: 0.1
  }
  scale {
    x: 5.3E-4
    y: 6.8E-4
    z: 7.0E-4
  }
}
