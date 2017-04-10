Shader "Custom/s21" {
	Properties{
		_Specular("Specular",color) = (1,1,1,1)
		_Shininess("Shininess",Range(1,20)) = 4
	}

	SubShader{
		Tags{"LightMode" = "ForwardBase"}

		Pass{
		
			CGPROGRAM 
			//#pragma multi_compile_fwdbase
			#pragma vertex vert
			#pragma fragment frag
		
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
		
			float4 _Specular;
			float _Shininess;

			struct v2f{
				float4 pos:POSITION;
				float3 normal:NORMAL;
				float3 lightDir:COLOR;
			};

			v2f vert(appdata_base v)
			{
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP,v.vertex);

				//放在 Vert中不能得到底层差值化的法向量和 光线方向
				o.normal = UnityObjectToWorldNormal(v.normal);
				o.lightDir = normalize(WorldSpaceLightDir(v.vertex));

				return o;
			}

			fixed4 frag(v2f IN):COLOR
			{
				//Ambient Light
				fixed4 col = UNITY_LIGHTMODEL_AMBIENT;
				//Diffuse Light
				col += saturate(dot(IN.normal,IN.lightDir)) * _LightColor0;
				

				return col;
			}

			ENDCG
		}
	}
	FallBack "Diffuse"
}
