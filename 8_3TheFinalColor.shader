Shader "Custom/8_3TheFinalColor" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_FinalColor ("The Final Color", Color) = (1, 1, 1, 1)
	}
	SubShader {
		CGPROGRAM
		#pragma surface surf Lambert finalcolor:myColor

		sampler2D _MainTex;
		fixed4 _FinalColor;

		struct Input {
			float2 uv_MainTex;
		};

		void myColor(Input IN, SurfaceOutput o, inout fixed4 color) {
			color *= _FinalColor;
		}

		void surf(Input IN, inout SurfaceOutput o) {
			half4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
}
