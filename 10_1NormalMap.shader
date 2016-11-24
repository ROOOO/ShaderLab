Shader "Custom/10_1NormalMap" {
	Properties {
		_MainTex ("Texture (RGB)", 2D) = "white" {}
		_NormalMap ("NormalMap", 2D) = "white" {}
	}
	SubShader {
		CGPROGRAM
		#pragma surface surf BlinnPhong

		sampler2D _MainTex;
		sampler2D _NormalMap;

		struct Input {
			float2 uv_MainTex;
		};

		float3 expand(float3 v) {
			return (v - 0.5) * 2;
		}
		float3 expand2(float4 v) {
			fixed3 normal;
			normal.xy = v.wy * 2 - 1;
			normal.z = sqrt(1 - normal.x * normal.x - normal.y * normal.y);
			return normal;
		}

		void surf(Input IN, inout SurfaceOutput o) {
			half4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Alpha = c.a;

			half4 packedNormal = tex2D(_NormalMap, IN.uv_MainTex);
			// o.Normal = expand(packedNormal.xyz);
			// o.Normal = expand2(packedNormal);
			o.Normal = UnpackNormal(packedNormal);
		}

		ENDCG
	}
}
