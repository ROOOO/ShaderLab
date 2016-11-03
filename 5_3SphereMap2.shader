Shader "Custom/5_3SphereMap2" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}
	SubShader {
        Pass {
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

            v2f vert(float4 v : POSITION, float3 n : NORMAL) {
                v2f o;
                o.pos = mul(UNITY_MATRIX_MVP, v);

                float3 viewDir = normalize(ObjSpaceViewDir(v));
                float3 r = reflect(-viewDir, n);
                r = mul((float3x3)UNITY_MATRIX_MV, r);
                r.z += 1;
                float m = 2 * length(r);
                o.uv = r.xy / m + 0.5f;

                return o;
            }

            float4 frag(v2f i) : COLOR {
                return tex2D(_MainTex, i.uv);
            }

            ENDCG
        }
	}
}
