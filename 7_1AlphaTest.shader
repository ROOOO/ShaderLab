Shader "Custom/7_1AlphaTest" {
	Properties {
		_Color ("Main Color", Color) = (1, 1, 1, 0)
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Cutoff ("Cutoff", Range(0, 1)) = 0
	}
	SubShader {
		Pass {
			Material {
				Diffuse [_Color]
			}

			Lighting On
			// AlphaTest Always 0
			// AlphaTest Never 0
			// AlphaTest Greater 0.2
			// AlphaTest GEqual 0.2
			// AlphaTest Less 0.2
			// AlphaTest Equal 0
			// AlphaTest NotEqual 0

			AlphaTest Greater [_Cutoff]

			SetTexture [_MainTex] {
				combine primary * texture
			}
		}
	}
}
