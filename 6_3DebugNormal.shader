Shader "Custom/6_3DebugNormal" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
	}
	SubShader {
		Pass {
			Material {
				Diffuse (1, 1, 1, 1)
			}
			Lighting On
			SetTexture [_MainTex] {
				Combine Primary * texture
			}
		}

		Pass {
			Color (1, 0, 1, 1)
			Cull Front
		}
	}
}
