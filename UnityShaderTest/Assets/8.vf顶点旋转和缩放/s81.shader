Shader "Custom/s81" {
	Properties {
		_Distort("Distort",Range(1,10)) = 1
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

			float _Distort;

			v2f vert(appdata_base v)
			{
				v2f o;
				//float d = length(v.vertex);
				float d = sqrt(v.vertex.x * v.vertex.x + v.vertex.z * v.vertex.z)*_SinTime.w/_Distort;
				
				//矩阵
				//float4x4 m = {
				//	float4(cos(d),0,sin(d),0),
				//	float4(0,1,0,0),
				//	float4(-sin(d),0,cos(d),0),
				//	float4(0,0,0,1)
				//};

				//优化矩阵运算
				//float x = cos(d) * v.vertex.x + sin(d) * v.vertex.z;
				//float z = cos(d) * v.vertex.z - sin(d) * v.vertex.x;
				//v.vertex.x = x;
				//v.vertex.z = z;

				float x = sin(d/4 + 0.75) * v.vertex.x;
				v.vertex.x = x;

				o.pos = mul(UNITY_MATRIX_MVP,v.vertex); 
				o.col = fixed4(1, 1, 0, 1);
				return o;

			}

			fixed4 frag(v2f IN):Color
			{
				//return IN.col;
			return IN.col;
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
