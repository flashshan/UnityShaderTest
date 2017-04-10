Shader "Custom/s71" {
	Properties{
		_High("hight", Range(0,5)) = 1
	}

	SubShader{

		Pass{
			CGPROGRAM
			
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			float _High;

			struct v2f{
				float4 pos:POSITION;
				fixed4 col:COLOR;
			};

			v2f vert(appdata_base v)
			{
				v2f o;
				float d = _High - sqrt(v.vertex.x * v.vertex.x + v.vertex.z * v.vertex.z);
				d = d>0? d:0;
				float4 temp = v.vertex + float4(0,d,0,0);
				o.pos = mul(UNITY_MATRIX_MVP, temp); //
				o.col = fixed4(d, d,d,1);
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
