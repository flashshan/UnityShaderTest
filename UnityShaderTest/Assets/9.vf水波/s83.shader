Shader "Custom/s83" {
	Properties {
		_xHigh("xHigh",Range(1,5)) = 1
		_zHigh("zHigh",Range(1,5)) = 1
		_xDistort("xDistort",Range(1,10)) = 1
		_zDistort("zDistort",Range(1,10)) = 1
		_xSpeed("xSpeed",Range(1,10)) = 1
		_zSpeed("zSpeed",Range(1,10)) = 1
	}
	SubShader {
		Pass{
		
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
		
			#include "UnityCG.cginc"

			struct v2f{
				float4 pos:POSITION;
				fixed4 col:COLOR;
			};

			float _xHigh, _zHigh, _xDistort, _zDistort, _xSpeed, _zSpeed;

			v2f vert(appdata_base v)
			{
				v2f o;

				//垂直水波
				//v.vertex.y = sin(v.vertex.x * _xDistort * 2 + _Time.w * _xSpeed * 0.3) * _xHigh/5 + 
				//			 sin(v.vertex.z * _zDistort * 2 + _Time.w * _zSpeed * 0.3) * _zHigh/5;
				
				//圆形波
				//v.vertex.y = sin(sqrt(v.vertex.x * v.vertex.x + v.vertex.z * v.vertex.z)*1 + _Time.w )* 0.5;
						
				//斜向水波
				v.vertex.y = sin(v.vertex.x * _xDistort * 2 + _Time.w * _xSpeed * 0.3) * _xHigh/20 + 
							 sin(v.vertex.z * _zDistort * 2 + _Time.w * _zSpeed * 0.3) * _zHigh/20 + 
							 sin(v.vertex.x * 6 + v.vertex.z * 5 + _Time.w * 1) * 0.05 + 
							 sin(v.vertex.x * 4 - v.vertex.z * 5 + _Time.w * 0.6) * 0.1;			
				
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.col = fixed4(v.vertex.y/2+0.2,v.vertex.y/2+0.2,v.vertex.y/2+0.2,1);

				return o; 
			}

			fixed4 frag(v2f IN):Color
			{
				return IN.col;
			}
		
			ENDCG
		}
	}
	FallBack "Diffuse"
}
