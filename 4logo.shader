Shader "Custom/4logo" {
	Properties {
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader {
		Tags {
			"RenderType" = "Transparent"
			"Queue" = "Transparent"
			"IgnoreProjector" = "True"
		}
		Blend SrcAlpha OneMinusSrcAlpha
		AlphaTest Greater 0.1

		pass {
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			sampler2D _MainTex;
			float4 _MainTex_ST;

			struct v2f {
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			v2f vert(appdata_base v) {
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
				return o;
			}

			float inFlash(float angle, float2 uv, float xLength, int interval, int beginTime, float offsetX, float loopTime) {
				float brightness = 0;
				return brightness;
			}

			float4 frag(v2f i) : COLOR {
				float4 output;
				float4 texColor = tex2D(_MainTex, i.uv);
				float brightness = inFlash(75, i.uv, 0.25f, 5, 2, 0.15f, 0.7f);
				if(texColor.w > 0.5) {
					output = texColor + float4(1.0f, 1.0f, 1.0f, 1.0f) * brightness;
				} else {
					output = float4(0.0f, 0.0f, 0.0f, 0.0f);
				}
				return output;
			}

			ENDCG
		}
	}
}
