Shader "Custom/s51" {
	Properties {
		_MainColor ("Main Color", Color) = (1,1,1,1)
		_SecondColor ("Second Color", color) = (1,1,1,1)
		_ThirdColor ("Thrid Color", color) =(1,1,1,1)
		_ForthColor ("Forth Color",color) = (1,1,1,1)
		_CenterX("CenterX",Range(-1,1)) = 0
		_CenterY("CenterY", Range(-1,1)) = 0
		_LengthX("LengthX", Range(0,0.5)) = 0.1
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		
		Pass{
			
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include "Lighting.cginc"

			float4 _MainColor;
			float4 _SecondColor;
			float4 _ThirdColor;
			float4 _ForthColor;
			float _CenterX;
			float _CenterY;
			float _LengthX;

			struct v2f{
				float4 pos:POSITION;
				float3 normal:NORMAL;
				float4 vertex:COLOR;
			};
			
			v2f vert(appdata_base v)
			{
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.normal = v.normal;
				o.vertex = v.vertex;
				return o;
			}

			fixed4 frag(v2f IN):COLOR
			{
				//if else 处理4种颜色
				//if(IN.vertex.x > _CenterX)
				//{
				//	if(IN.vertex.y > _CenterY) return _MainColor;
				//	else return _SecondColor;
				//}
				//else
				//{
				//	if(IN.vertex.y > _CenterY) return _ThirdColor;
				//	else return _ForthColor;
				//}

				//不用if else的写法（不支持嵌套判断）
				//float dx = IN.vertex.x - _CenterX;
				//dx = dx/abs(dx);
				//dx = dx/2 + 0.5;
				//return lerp(_MainColor, _SecondColor,dx);
				
				//结合点融合
				float dx = IN.vertex.x - _CenterX;
				return lerp(_SecondColor,_MainColor,saturate(dx*2/_LengthX + 1));

			}

			ENDCG
		}
	}
	FallBack "Diffuse"
}
