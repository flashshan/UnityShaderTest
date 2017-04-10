Shader "Custom/s81" {
	Properties {
		_MainTex("MainTex",2D) = ""{}
		_X("X",Range(-1,3)) = 0.5
		_Y("Y",Range(-1,3)) = 0.5
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
			float _X,_Y;
			float4 _MainTex_ST;

			struct v2f{
				float4 pos:POSITION;
				float3 normal:NORMAL;
				float4 vertex:COLOR;
				float2 uv:TEXCOORD0;
			};
			
			v2f vert(appdata_base v){
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				//o.uv = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				o.uv = TRANSFORM_TEX(v.texcoord,_MainTex);
				o.normal = v.normal;
				o.vertex = v.vertex;
				
				return o;
			}	

			fixed4 frag(v2f IN):Color
			{
				//fixed4 col = tex2D(_MainTex, float2(IN.vertex.x+0.5,IN.vertex.y + 0.5));
				fixed4 col = tex2D(_MainTex,IN.uv);
				return col; 
				//return fixed4(IN.vertex.x+0.5,IN.vertex.y+0.5,IN.vertex.z+0.5,1);
			}

			ENDCG
		}
	}
	FallBack "Diffuse"
}
