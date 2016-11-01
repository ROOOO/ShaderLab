Shader "Custom/1_3color" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_MainTex2 ("Tex2 (RGB)", 2D) = "white" {}
		_Color ("Color", Color) = (1,1,1,1)
	}
	SubShader {
		Pass {
			Material {
				Diffuse [_Color]
			}
			Lighting On
			SetTexture [_MainTex] {
				Combine texture * primary
			}
			SetTexture [_MainTex2] {
				Combine texture * previous
			}
		}
	}
}
