Shader "Custom/s201" {
	Properties {
		_MainTex("MainTex",2D) = ""{}
		_CenterX("CenterX",Range(0,1)) = 0.5
		_CenterY("CenterY",Range(0,1)) = 0.5
		_Radius("Radius",Range(0,1)) = 0.5
		_Amplitude("Amplitude",Range(0.01,0.3)) = 0.1
		_WaterSpeed("WaterSpeed",Range(1,100)) = 4
		_PeriodSpeed("PeriodSpeed",Range(1,100)) = 4
		_RingColor("RingColor",Range(0,10)) = 1
		
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
			float _CenterX,_CenterY,_Radius;
			float _Amplitude, _WaterSpeed, _PeriodSpeed, _RingColor;

			struct v2f{
				float4 pos:POSITION;
				float4 vertex:COLOR;
				float2 uv:TEXCOORD0;
			};
			
			v2f vert(appdata_base v){
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				//o.uv = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				o.uv = TRANSFORM_TEX(v.texcoord,_MainTex);
				o.vertex = v.vertex;
				
				return o;
			}	

			fixed4 frag(v2f IN):Color
			{
				//fixed4 col = tex2D(_MainTex, float2(IN.vertex.x+0.5,IN.vertex.y + 0.5));
				//IN.uv.x += _Amplitude * sin(IN.uv.x * _WaterSpeed + _Time.y * _PeriodSpeed);
				
				
				float dis = distance(IN.uv,float2(1-_CenterX,1-_CenterY));
				
				float amp = saturate(1 - dis/_Radius); 
				float scale = amp * _Amplitude * sin(-dis * _WaterSpeed + _Time.y * _PeriodSpeed);  //控制拉伸幅度和颜色变化
				scale /= _Radius;   //产生近大远小
				IN.uv += IN.uv * scale * _Amplitude;   //产生拉伸

				fixed4 col = tex2D(_MainTex,IN.uv) + fixed4(1,1,1,1) * saturate(scale)* _RingColor;
				
				return col; 
				//return fixed4(IN.vertex.x+0.5,IN.vertex.y+0.5,IN.vertex.z+0.5,1);
			}

			ENDCG
		}
	}
	FallBack "Diffuse"
}
