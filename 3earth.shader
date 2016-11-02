Shader "Custom/3earth" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Earth (RGB)", 2D) = "white" {}
		_CloudTex ("Cloud (RGB)", 2D) = "white" {}
	}
	SubShader {
		Pass {
			Tags { "RenderType"="Opaque" }
			LOD 200

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			sampler2D _MainTex;
			float4 _MainTex_ST;
			sampler2D _CloudTex;
			float4 _Color;

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

			float4 frag(v2f i) : COLOR {
				float2 earthUV = float2(i.uv.x + (-1) * _Time.x, i.uv.y);
				float4 earthTex = tex2D(_MainTex, earthUV);
				float2 cloudUV = float2(i.uv.x + (-2) * _Time.x, i.uv.y);
				float4 cloudTex = tex2D(_CloudTex, cloudUV) * _Color;

				return lerp(earthTex, cloudTex, 0.5f);
			}

			ENDCG
		}
	}
	FallBack "Diffuse"
}
