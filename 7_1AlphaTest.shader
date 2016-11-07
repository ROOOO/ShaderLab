Shader "Custom/7_1AlphaTest" {
	Properties {
		_Color ("Main Color", Color) = (1, 1, 1, 0)
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}
	SubShader {
		Pass {
			Material {
				Diffuse [_Color]
			}

			Lighting On

			Blend SrcAlpha OneMinusSrcAlpha

			SetTexture [_MainTex] {
				combine primary * texture
			}
		}
	}
}
