﻿Shader "Custom/5_5CubeNormal2" {
	Properties {
        _Cube ("CubeMap", Cube) = "" {}
	}
	SubShader {
        Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            samplerCUBE _Cube;

            struct v2f {
                float4 pos : SV_POSITION;
                float3 uv : TEXCOORD0;
            };

            v2f vert(float4 v : POSITION, float3 n : NORMAL) {
                v2f o;
                o.pos = mul(UNITY_MATRIX_MVP, v);

                o.uv = mul((float3x3)UNITY_MATRIX_MV, n);

                return o;
            }

            half4 frag(v2f i) : SV_Target {
                return texCUBE(_Cube, i.uv);
            }

            ENDCG
        }
	}
}
