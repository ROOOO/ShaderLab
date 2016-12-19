Shader "Custom/10_3GrabPass" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "Queue" = "Transparent" }

		GrabPass {}
		Pass {
			SetTexture [_GrabTexture] {
				Combine one - texture
			}
		}
	}
}
