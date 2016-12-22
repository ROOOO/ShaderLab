Shader "Custom/11_2CubeMapping" {
	Properties {
		_Environment ("Environment", Cube) = "white" {}
	}
	SubShader {
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			samplerCUBE _Environment;

			struct v2f {
				float4 pos: SV_POSITION;
				float3 R: TEXCOORD0;
			};

			float3 reflect(float3 I, float3 N) {
				return I - 2.0f * N * dot(N, I);
			}

			v2f vert(appdata_base v) {
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);

				float3 posW = mul(UNITY_MATRIX_MVP, v.vertex).xyz;
				float3 I = posW - _WorldSpaceCameraPos.xyz;
				float3 N = normalize(mul((float3x3)_Object2World, v.normal));

				o.R = reflect(I, N);

				return o;
			}

			float4 frag(v2f i): COLOR {
				float4 reflectiveColor = texCUBE(_Environment, i.R);
				return reflectiveColor;
			}

			ENDCG
		}
	}
}
