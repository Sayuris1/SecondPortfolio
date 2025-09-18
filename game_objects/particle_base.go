components {
  id: "trail_maker"
  component: "/hyper_trails/trail_maker.script"
  properties {
    id: "use_world_position"
    value: "true"
    type: PROPERTY_TYPE_BOOLEAN
  }
  properties {
    id: "trail_width"
    value: "15.0"
    type: PROPERTY_TYPE_NUMBER
  }
  properties {
    id: "segment_length_max"
    value: "0.0"
    type: PROPERTY_TYPE_NUMBER
  }
  properties {
    id: "segment_length_min"
    value: "0.0"
    type: PROPERTY_TYPE_NUMBER
  }
  properties {
    id: "points_count"
    value: "40.0"
    type: PROPERTY_TYPE_NUMBER
  }
  properties {
    id: "points_limit"
    value: "0.0"
    type: PROPERTY_TYPE_NUMBER
  }
  properties {
    id: "fade_tail_alpha"
    value: "0.0"
    type: PROPERTY_TYPE_NUMBER
  }
  properties {
    id: "shrink_tail_width"
    value: "true"
    type: PROPERTY_TYPE_BOOLEAN
  }
  properties {
    id: "shrink_length_per_sec"
    value: "0.0"
    type: PROPERTY_TYPE_NUMBER
  }
}
components {
  id: "trail_mesh"
  component: "/hyper_trails/models/trail_mesh.mesh"
}
embedded_components {
  id: "collisionobject"
  type: "collisionobject"
  data: "type: COLLISION_OBJECT_TYPE_TRIGGER\n"
  "mass: 0.0\n"
  "friction: 0.1\n"
  "restitution: 0.5\n"
  "group: \"particle\"\n"
  "mask: \"base\"\n"
  "embedded_collision_shape {\n"
  "  shapes {\n"
  "    shape_type: TYPE_SPHERE\n"
  "    position {\n"
  "    }\n"
  "    rotation {\n"
  "    }\n"
  "    index: 0\n"
  "    count: 1\n"
  "    id: \"sphere\"\n"
  "  }\n"
  "  data: 6.5\n"
  "}\n"
  "bullet: true\n"
  "event_collision: false\n"
  "event_contact: false\n"
  ""
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"anim\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/builtins/graphics/particle_blob.tilesource\"\n"
  "}\n"
  ""
}
