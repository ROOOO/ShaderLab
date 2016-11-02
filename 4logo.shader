Shader "Custom/4logo" {
	Properties {
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader {
		Tags {
			"RenderType" = "Transparent"
			"Queue" = "Transparent"
			"IgnoreProjector" = "True"
		}
		Blend SrcAlpha OneMinusSrcAlpha
		AlphaTest Greater 0.1

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

			v2f vert(appdata_base v) {
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
				return o;
			}

			float inFlash(float angle, float2 uv, float xLength, int interval, int beginTime, float offsetX, float loopTime) {
				float brightness = 0;
				float angleInRad = 3.141592654 / 180 * angle;
				float currentTime = _Time.y;

				// 获取本次光照起始时间
				int currentTimeInt = (_Time.y / interval);
				currentTimeInt *= interval;

				// 获取本次光照的流逝时间
				float currentTimePassed = currentTime - currentTimeInt;
				if (currentTimePassed > beginTime) {
					float xBottomLeftBound;
					float xBottomRightBound;
					float xPointLeftBound;
					float xPointRightBound;

					float x0 = currentTimePassed - beginTime;
					x0 /= loopTime;

					xBottomRightBound = x0;
					xBottomLeftBound = x0 - xLength;

					float xProjL = uv.y / tan(angleInRad);
					xPointLeftBound = xBottomLeftBound - xProjL;
					xPointRightBound = xBottomRightBound - xProjL;

					xPointLeftBound += offsetX;
					xPointRightBound += offsetX;

					if (uv.x > xPointLeftBound && uv.x < xPointRightBound) {
						float midness = (xPointLeftBound + xPointRightBound) / 2;
						float rate = (xLength - 2 * abs(uv.x - midness)) / xLength;
						brightness = rate;
					}
				}
				brightness = max(brightness, 0);

				return brightness * float4(1.0f, 1.0f, 1.0f, 1.0f);
			}

			float4 frag(v2f i) : COLOR {
				float4 output;
				float4 texColor = tex2D(_MainTex, i.uv);
				float brightness = inFlash(75, i.uv, 0.25f, 5, 2, 0.15f, 0.7f);
				if (texColor.w > 0.5) {
					output = texColor + float4(1.0f, 1.0f, 1.0f, 1.0f) * brightness;
				} else {
					output = float4(0.0f, 0.0f, 0.0f, 0.0f);
				}
				return output;
			}

			ENDCG
		}
	}
}
