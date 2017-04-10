// Upgrade NOTE: commented out 'float4 unity_LightmapST', a built-in variable
// Upgrade NOTE: commented out 'sampler2D unity_Lightmap', a built-in variable
// Upgrade NOTE: replaced tex2D unity_Lightmap with UNITY_SAMPLE_TEX2D

Shader "Custom/s91" {
	Properties {
		_MainTex("MainTex",2D) = ""{}
	}
	SubShader {
		Tags{}
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			
			sampler2D _MainTex;
			float4 _MainTex_ST;
			// sampler2D unity_Lightmap;
			// float4 unity_LightmapST;

			struct v2f{
				float4 pos:POSITION;
				float3 normal:NORMAL;
				float4 vertex:COLOR;
				float2 uv:TEXCOORD0;
				float2 uv2:TEXCOORD1;
			};
			
			v2f vert(appdata_full v){
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				//o.uv = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				o.uv = TRANSFORM_TEX(v.texcoord,_MainTex);
				o.normal = v.normal;
				o.vertex = v.vertex;
				o.uv2 = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
				
				return o;
			}	

			fixed4 frag(v2f IN):Color
			{
				//fixed4 col = tex2D(_MainTex, float2(IN.vertex.x+0.5,IN.vertex.y + 0.5));
				fixed4 col = tex2D(_MainTex,IN.uv);
				float3 lm = DecodeLightmap( UNITY_SAMPLE_TEX2D(unity_Lightmap,IN.uv2));
				col.rgb *= lm*2;

				return col; 
				//return fixed4(IN.vertex.x+0.5,IN.vertex.y+0.5,IN.vertex.z+0.5,1);
			}

			ENDCG
		}
	}
	FallBack "Diffuse"
}