Shader "Custom/5_3SphereMap1" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" { TexGen SphereMap }
	}
	SubShader {
		Pass {
			SetTexture [_MainTex] {
				combine texture
			}
		}
	}
}
