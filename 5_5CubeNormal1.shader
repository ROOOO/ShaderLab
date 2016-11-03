Shader "Custom/5_5CubeNormal1" {
	Properties {
		_Cube ("Cube", Cube) = "" { TexGen CubeNormal }
	}
	SubShader {
		Pass {
			SetTexture [_MainTex] {
				combine texture
			}
		}
	}
}
