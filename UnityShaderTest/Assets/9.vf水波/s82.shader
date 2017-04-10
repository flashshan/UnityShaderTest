Shader "Custom/s82" {
	Properties {
		_Distort("Distort",Range(1,10)) = 1
		_Speed("Speed", Range(1,10)) = 1
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

		float _Distort,_Speed;

		v2f vert(appdata_base v)
		{
			v2f o;
			v.vertex.x *= sin(v.vertex.z * _Distort * 0.1 + _Time.w * 0.3 *_Speed)/5 + 0.8;
			
			o.pos = mul(UNITY_MATRIX_MVP,v.vertex);
			return o; 

		}

		fixed4 frag(v2f IN):COLOR
		{
			return IN.col;
		}
		
		ENDCG
		}
	}
}
