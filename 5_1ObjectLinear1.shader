Shader "Custom/5_1ObjectLinear1" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" { TexGen ObjectLinear }
	}
	SubShader {
		Pass {
			SetTexture [_MainTex] {
				combine texture
			}
		}
	}
}
