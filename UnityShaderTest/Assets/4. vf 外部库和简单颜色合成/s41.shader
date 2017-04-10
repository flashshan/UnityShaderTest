Shader "Custom/s41" {
	Properties{
		_MainColor("Main Color", color) = (1,1,0,1)
		_SecondColor("Second Color", color) = (0,0,1,1)
	}

	
	SubShader{
		
		Pass{
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			//#include "testLib.cginc"
			#include "UnityCG.cginc"


			struct v2f{
				float4 pos:POSITION;
				//float2 objPos:TEXCOORD0;
			};

			float4 _MainColor;
			uniform float4 _SecondColor;

			v2f vert(appdata_base v)
			{
				v2f o;
				//if(objPos.x<0.0f)
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				//o.objPos = float2(1,0);//float2(1,0);
				
				return o;
			}

			float4 frag(in v2f IN):COLOR
			{
				//Func(col);  
				//col = float4(1,1,1,1);
			    //return IN.pos;
				//return float4(IN.objPos,0,1);
				//return IN.col; 
				return lerp(_MainColor,_SecondColor, 0.5);
				//return float4(opos,0,1);
			}
			
			

			ENDCG
		}
	}
}