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
  "  name: \"default\"\n"
  "  material: \"/materials/arrow.material\"\n"
  "  textures {\n"
  "    sampler: \"DATA_TEXTURE\"\n"
  "    texture: \"/illumination/textures/data.png\"\n"
  "  }\n"
  "  textures {\n"
  "    sampler: \"DIFFUSE_TEXTURE\"\n"
  "    texture: \"/illumination/textures/white.png\"\n"
  "  }\n"
  "  textures {\n"
  "    sampler: \"LIGHT_TEXTURE\"\n"
  "    texture: \"/illumination/textures/empty.png\"\n"
  "  }\n"
  "  textures {\n"
  "    sampler: \"NORMAL_TEXTURE\"\n"
  "    texture: \"/illumination/textures/empty.png\"\n"
  "  }\n"
  "  textures {\n"
  "    sampler: \"SPECULAR_TEXTURE\"\n"
  "    texture: \"/illumination/textures/white.png\"\n"
  "  }\n"
  "}\n"
  ""
  position {
    y: -0.05
  }
  rotation {
    x: 0.70710677
    w: 0.70710677
  }
}
