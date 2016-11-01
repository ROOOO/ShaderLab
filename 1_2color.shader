Shader "Custom/1_2color" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Color ("Main Color", Color) = (1, 0.5, 0.5, 1)
	}
	SubShader {
		Pass {
			Material {
				Diffuse [_Color]
			}
			Lighting On
			SetTexture [_MainTex] {
				// constantColor [_Color]
				Combine texture * primary, texture * constant
			}
		}
	}
}
