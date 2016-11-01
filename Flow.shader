Shader "Custom/Flow" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_FlowTex ("Texture (Alpha)", 2D) = "black" {}
		_MaskTex ("Texture (Mask)", 2D) = "white" {}
		_UVAdd ("", Range(0, 1)) = 0
		_UVSpeed ("Speed", float) = 2
	}
	SubShader {
		Tags {
			"RenderType" = "Opaque"
			"Queue" = "Transparent"
		}
		LOD 200
		Blend SrcAlpha OneMinusSrcAlpha

		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		sampler2D _FlowTex;
		sampler2D _MaskTex;
		float _UVAdd;
		float _UVSpeed;

		struct Input {
			float2 uv_MainTex;
			float3 worldNormal;
		};

		void surf(Input IN, inout SurfaceOutput o) {
			// float2 uv = IN.uv_MainTex;
			// uv.x /= 2;
			// uv.x -= _Time.y * _UVSpeed;
			// float flow = tex2D(_FlowTex, uv).a;

			float2 ruv = IN.worldNormal.xy;
			ruv = ruv * 0.5;
			ruv += _Time.xx * _UVSpeed;

			float mask = tex2D(_MaskTex, IN.uv_MainTex);

			// half4 c = tex2D(_MainTex, IN.uv_MainTex);
			// o.Albedo = float3(flow, flow, flow) * mask + c.rgb;
			half4 c = tex2D(_MainTex, IN.uv_MainTex) + tex2D(_FlowTex, ruv.xy) * mask;
			o.Emission = c.rgb;
			o.Alpha  = c.a;
		}

		ENDCG
	}
	FallBack "Diffuse"
}
