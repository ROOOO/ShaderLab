Shader "Custom/10_2MutiPass" {
	Properties {
		_MainTex ("Texture (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags {
			"Queue" = "Transparent"
		}
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			sampler2D _MainTex;
			float4 _MainTex_ST;
			struct v2f {
				float4 pos: SV_POSITION;
				float2 uv: TEXCOORD0;
			};

			v2f vert(appdata_base v) {
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
				return o;
			}
			float4 frag(v2f i): COLOR {
				float4 texColor = tex2D(_MainTex, i.uv + 0.1);
				return texColor * float4(1.0f, 0.0f, 0.0f, 1.0f);
			}

			ENDCG
		}
		Pass {
			blend one one
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			sampler2D _MainTex;
			float4 _MainTex_ST;
			struct v2f {
				float4 pos: SV_POSITION;
				float2 uv: TEXCOORD0;
			};

			v2f vert(appdata_base v) {
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
				return o;
			}
			float4 frag(v2f i): COLOR {
				float4 texColor = tex2D(_MainTex, i.uv);
				return texColor * float4(0.0f, 1.0f, 0.0f, 1.0f);
			}

			ENDCG
		}
	}
}
