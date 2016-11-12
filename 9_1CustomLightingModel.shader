Shader "Custom/9_1CustomLightingModel" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
	}
	SubShader {
		AlphaTest Greater 0.4

		CGPROGRAM
		#pragma surface surf CustomLightModel

		float4 LightingCustomLightModel(SurfaceOutput s, float3 lightDir, half3 viewDir, half atten) {
			float4 c = 0;
			
			float diffuse = max(0, dot(s.Normal, lightDir));

			float specular = 0;
			float3 H = normalize(lightDir + viewDir);
			specular = pow(max(dot(s.Normal, H), 0), 8);

			c.rgb = s.Albedo * _LightColor0 * diffuse * atten + _LightColor0 * specular;
			c.a = s.Alpha;

			return c;
		}

		sampler2D _MainTex;
		fixed4 _FinalColor;

		struct Input {
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutput o) {
			half4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}

		ENDCG
	}
}
