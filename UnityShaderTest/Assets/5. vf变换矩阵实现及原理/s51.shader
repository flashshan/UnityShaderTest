Shader "Custom/s51" {
	
	SubShader{

		Pass{
			
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			float4x4 ro,sm;

			struct v2f{
				float4 pos:POSITION;
				fixed4 col:COLOR;
			};

			v2f vert(appdata_base v)
			{
				v2f o;
				o.pos = mul(mul(mul(UNITY_MATRIX_MVP, sm), ro), v.vertex);
				//if(v.vertex.x<0 && v.vertex.y<0) o.col = fixed4(1,0,0,1);
				//else o.col = fixed4(0,0,1,1);
				//o.col = v.vertex;
				float wpos = mul(_Object2World,v.vertex);
				
				//if(wpos.x<0) o.col = fixed4(1,0,0,1);
				//else o.col = fixed4(0,0,1,1);
				o.col = float4(_SinTime.w/2+0.5,_CosTime.w/2+0.5,0,1);

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
