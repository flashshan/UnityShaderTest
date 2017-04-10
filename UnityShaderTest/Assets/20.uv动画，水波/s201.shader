Shader "Custom/s201" {
	Properties {
		_MainTex("MainTex",2D) = ""{}
		_Amplitude("Amplitude",Range(0.01,0.3)) = 0.1
		_WaterSpeed("WaterSpeed",Range(0.1,20)) = 4
		_PeriodSpeed("PeriodSpeed",Range(0.1,10)) = 4
		
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
			float _Amplitude, _WaterSpeed, _PeriodSpeed;

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
				IN.uv.x += _Amplitude * sin(IN.uv.x * _WaterSpeed + _Time.y * _PeriodSpeed);
				fixed4 col = tex2D(_MainTex,IN.uv);
				return col; 
				//return fixed4(IN.vertex.x+0.5,IN.vertex.y+0.5,IN.vertex.z+0.5,1);
			}

			ENDCG
		}
	}
	FallBack "Diffuse"
}
