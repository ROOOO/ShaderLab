Shader "Custom/6_4GlassCulling" {
	Properties {
		_Color ("Main Color", Color) = (1, 1, 1, 0)
		_SpecColor ("SpecColor", Color) = (1, 1, 1, 1)
		_Emission ("Emission", Color) = (0, 0, 0, 0)
		_Shininess ("Shininess", Range(0.1, 1)) = 0.7
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}
	SubShader {
		Material {
			Diffuse [_Color]
			Ambient [_Color]
			Shininess [_Shininess]
			Specular [_SpecColor]
			Emission [_Emission]
		}

		Lighting On
		SeparateSpecular On

		Blend SrcAlpha OneMinusSrcAlpha

		Pass {
			Cull Front
			SetTexture [_MainTex] {
				Combine Primary * Texture
			}
		}

		Pass {
			Cull Back
			SetTexture [_MainTex] {
				Combine Primary * Texture
			}
		}
	}
}
