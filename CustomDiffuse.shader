Shader "Custom/CustomDiffuse"
{
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Bump ("Bump", 2D) = "bump" {}
		_AddColor ("Add Color", Color) = (0, 0, 0, 0)
		_AddTex ("Add (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags {"RenderType" = "Opaque"}
		LOD 200

		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		sampler2D _Bump;
		sampler2D _AddTex;
		float4 _AddColor;

		struct Input {
			float2 uv_MainTex;
			float2 uv_Bump;
		};

		void surf(Input IN, inout SurfaceOutput o) {
			half4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Normal = UnpackNormal(tex2D(_Bump, IN.uv_Bump));
			half4 c2 = tex2D(_AddTex, IN.uv_MainTex);

			// o.Albedo = c.rgb;
			// o.Emission = c.rgb + _AddColor.rgb + c2.rgb;
			// o.Emission = c.rgb * _AddColor.rgb;
			// o.Emission = c.rgb * (1 - c2.a) + c2.rgb * c2.a;
			// c.r = c.g;
			// c.b = c.g;
			// o.Emission = c.rgb;
			o.Emission = c.r * 0.3 + c.g * 0.59 + c.b * 0.11;

			o.Alpha  = c.a;
		}

		// inline float4 LightLambert(SurfaceOutput s, fixed3 lightDir, fixed atten) {
		// 	float diff = max(dot(lightDir, s.Normal), 0);
		// 	float4 col;
		// 	col.rgb = s.Albedo * _LightColor0.rgb * (diff * atten * 2);
		// 	col.a = s.Alpha;
		// 	return col;
		// }

		ENDCG
	}
	FallBack "Diffuse"
}
