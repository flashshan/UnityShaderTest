Shader "Custom/s21" {
	Properties{
		_Specular("Specular",color) = (1,1,1,1)
		_Shininess("Shininess",Range(1,20)) = 4
	}

	SubShader{
		Tags{"LightMode" = "ForwardBase"}

		Pass{
		
			CGPROGRAM 
			#pragma multi_compile_fwdbase
			#pragma vertex vert
			#pragma fragment frag
		
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
		
			float4 _Specular;
			float _Shininess;

			struct v2f{
				float4 pos:POSITION;
				float3 normal:NORMAL;
				float4 vertex:COLOR;
			};

			v2f vert(appdata_base v)
			{
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP,v.vertex);

				//放在 Vert中不能得到底层差值化的法向量和 光线方向
				//o.normal = UnityObjectToWorldNormal(v.normal);
				//o.lightDir = normalize(WorldSpaceLightDir(v.vertex));

				o.normal = v.normal;
				o.vertex = v.vertex;
				return o;
			}

			fixed4 frag(v2f IN):COLOR
			{
				float3 N = UnityObjectToWorldNormal(IN.normal);
				float3 L = normalize(WorldSpaceLightDir(IN.vertex));
				//Ambient Light
				fixed4 col = UNITY_LIGHTMODEL_AMBIENT;
				//Diffuse Light
				col += saturate(dot(N,L)) * _LightColor0;

				//Specular Light  Phone
				float3 R = 2 * dot(N,L)*N - L;
				float3 V = normalize(WorldSpaceViewDir(IN.vertex));
				col += _Specular * pow(saturate(dot(R,V)),_Shininess);

				//BlinPhone
				//float3 V = normalize(WorldSpaceViewDir(IN.vertex));
				//float3 H = normalize(V+L);
				//col += _Specular * pow(saturate(dot(N,H)),_Shininess);

				//计算最多4个点光源的光照
				col.rgb += Shade4PointLights(unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
										 unity_LightColor[0].rgb, 
										 unity_LightColor[1].rgb,
										 unity_LightColor[2].rgb,
										 unity_LightColor[3].rgb,
										 unity_4LightAtten0, normalize(mul(_Object2World,IN.vertex).xyz), N);
			
				return col;
			}

			ENDCG
		}
	}
	FallBack "Diffuse"
}
