Shader "Custom/s61" {
	
	SubShader{

		Pass{
			
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct v2f{
				float4 pos:POSITION;
				fixed4 col:COLOR;
			
			};

			v2f vert(appdata_base v)
			{
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);

				float4 vpos = mul(UNITY_MATRIX_MV, v.vertex);

				if(vpos.x > _Time.w * 5 - 5 &&  vpos.x < _Time.w * 5 - 4)
				o.col = fixed4(1,0,0,1);
				else o.col = fixed4(1,1,1,1);
				return o;	
			}

			fixed4 frag(v2f IN):Color
			{
				return IN.col;
			}

			ENDCG
		}
	}
}
