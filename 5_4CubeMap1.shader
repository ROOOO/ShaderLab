Shader "Custom/5_3SphereMap1" {
	Properties {
		_Cube ("Cube", Cube) = "" { TexGen CubeReflect }
	}
	SubShader {
		Pass {
			SetTexture [_MainTex] {
				combine texture
			}
		}
	}
}
