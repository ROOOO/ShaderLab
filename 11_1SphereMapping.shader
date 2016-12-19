Shader "Custom/11_1SphereMapping" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Environment ("Environment", 2D) = "white" {}
		_Reflectivity ("Reflectivity", Range(0, 1)) = 0.5
	}
	SubShader {
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			sampler2D _MainTex;
			float4 _MainTex_ST;
			sampler2D _Environment;
			float4 _Environment_ST;
			float _Reflectivity;

			struct v2f {
				float4 pos: SV_POSITION;
				float2 uv: TEXCOORD0;
				float2 uv2: TEXCOORD1;
			};

			float3 reflect(float3 I, float3 N) {
				return I - 2.0f * N * dot(N, I);
			}

			float2 R_To_UV(float3 r) {
				float m = 2.0f * sqrt(r.x * r.x + r.y * r.y + (r.z + 1.0f) * (r.z * 1.0f));
				return float2(r.x / m + 0.5f, r.y / m + 0.5f);
			}

			v2f vert(appdata_base v) {
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);

				float3 posEyeSpace = mul(UNITY_MATRIX_MV, v.vertex).xyz;
				float3 I = posEyeSpace - float3(0.0f, 0.0f, 0.0f);
				float3 N = normalize(mul((float3x3)UNITY_MATRIX_MV, v.normal));

				float3 R = reflect(I, N);
				o.uv2 = R_To_UV(R);

				return o;
			}

			float4 frag(v2f i): COLOR {
				float4 reflectiveColor = tex2D(_Environment, i.uv2);
				float4 decalColor = tex2D(_MainTex, i.uv);
				return lerp(decalColor, reflectiveColor, _Reflectivity);
			}

			ENDCG
		}
	}
}
