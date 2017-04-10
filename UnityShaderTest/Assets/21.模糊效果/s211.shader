Shader "Custom/s211" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Diameter("Diameter", Range(0,1)) = 0.5
		_Levels("Levels", Range(2,5)) = 2
		_Pixels("Pixels", Range(0,10)) = 1

	}
	SubShader {
		Tags {}
		Pass{
			
			CGPROGRAM
			
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0
			#include "UnityCG.cginc"
			
			sampler2D _MainTex;
			float4 _MainTex_ST;
			float _Diameter, _Pixels, _Levels;

			struct v2f{
				float4 pos:POSITION;
				float2 uv:TEXCOORD;
				float z:TEXCOORD1;
			};

			v2f vert(appdata_full v)
			{
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = v.texcoord.xy;
				o.z = mul(UNITY_MATRIX_MV, v.vertex).z;
				return o;
			}

			fixed4 frag(v2f IN):Color
			{
				
				//float2 uv = IN.uv;
				//矩形分级模糊
				//float dis = max(abs(IN.uv.x - 0.5),abs(IN.uv.y - 0.5));
				//int tempL = floor(dis * _Levels /_Diameter); 
				//tempL = (tempL < _Levels)? tempL:_Levels;
				
				//float dx = ddx(IN.uv.x) * tempL * _Pixels;
				//float2 dsdx = float2(dx,dx);
				//float dy = ddy(IN.uv.y) * tempL * _Pixels;
				//float2 dsdy = float2(dy,dy);


				float2 dsdx = ddx(IN.z)* _Levels * _Pixels;
				float2 dsdy = ddy(IN.z) *_Levels * _Pixels;

				fixed4 col = tex2D(_MainTex,IN.uv,dsdx,dsdy);
				return col;
			}

			ENDCG
		}
	}
	FallBack "Diffuse"
}
