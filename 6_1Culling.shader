Shader "Custom/6_1Culling" {
	Properties {
		_Color ("Color", Color) = (1, 1, 1, 1)
	}
	SubShader {
		Pass {
			Material {
				Diffuse [_Color]
			}
			Lighting On
			Cull Front
		}
	}
}
