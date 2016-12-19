Shader "Custom/10_4GrabPassVF" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "Queue" = "Transparent" }

		GrabPass {}

		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			sampler2D _GrabTexture;
			float4 _GrabTexture_ST;

			struct v2f {
				float4 pos: SV_POSITION;
				float2 uv: TEXCOORD0;
			};

			v2f vert(appdata_base v) {
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = TRANSFORM_TEX(v.texcoord, _GrabTexture);
				return o;
			}

			float4 frag(v2f i): COLOR {
				return tex2D(_GrabTexture, float2(i.uv.x, 1 - i.uv.y));
			}

			ENDCG
		}
	}
}
