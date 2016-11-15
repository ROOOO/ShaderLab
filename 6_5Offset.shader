Shader "Custom/6_5Offset" {
	Properties {
		_Color ("Color", Color) = (1, 1, 1, 1)
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}
	SubShader {
		Pass {
			Material {
				Diffuse [_Color]
			}
			Lighting On
			ZWrite Off
			Offset 0, 1000
			SetTexture [_MainTex] {
				Combine texture * primary
			}
		}
	}
}
