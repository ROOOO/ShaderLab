Shader "Custom/5_2EyeLinear1" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" { TexGen EyeLinear }
	}
	SubShader {
		Pass {
			SetTexture [_MainTex] {
				combine texture
			}
		}
	}
}
