Shader "Custom/s221" {
	Properties {
		_MainTex ("Main Tex", 2D) = "white" {}
		_Scale("Scale",Range(0,2)) = 1
	}
	SubShader {
		Tags{}
		Pass{
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			
			struct v2f{
				float4 pos:POSITION;
				float2 uv:TEXCOORD0;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float _Scale;

			v2f vert(appdata_full v)
			{
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP,v.vertex);
				o.uv = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				return o;
			}

			fixed4 frag(v2f IN):COLOR
			{
				float2 uv = IN.uv, offset_uv;
				offset_uv.x = 0.01*sin(_Time.y/2+ IN.uv.x * _Scale);
				uv.x = IN.uv.x + offset_uv.x;
				fixed4 col = tex2D(_MainTex,uv)/2;
				uv.x = IN.uv.x - offset_uv.x;
				col += tex2D(_MainTex,uv)/2;
				return col;
								
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
