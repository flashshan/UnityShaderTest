Shader "Custom/s31" {
	Properties {
		_Specular("Specular",color) = (1,1,1,1)
		_Shininess("Shininess",Range(1,20)) = 4
	}
	SubShader {
		
		//Pass{
		//	tags {"LightMode" = "ShadowCaster"}
		//}
		pass
		{
			tags {"LightMode" = "ForwardBase"}
			
			CGPROGRAM
			#pragma multi_compile_fwdbase
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "AutoLight.cginc"

			float4 _Specular;
			float _Shininess;

			struct v2f{
				float4 pos:POSITION;
				float3 normal:NORMAL;
				float4 vertex:COLOR;
				
				//unityShadowCoord3 _LightCoord : TEXCOORD0;
				//unityShadowCoord3 _ShadowCoord : TEXCOORD1;
				LIGHTING_COORDS(0,1)
			};

			v2f vert(appdata_base v)
			{
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP,v.vertex);
				o.normal = v.normal;
				o.vertex = v.vertex;

				TRANSFER_VERTEX_TO_FRAGMENT(o)
				return o;
			}

			fixed4 frag(v2f IN):COLOR
			{
				float atten = LIGHT_ATTENUATION(IN);

				float3 N = UnityObjectToWorldNormal(IN.normal);
				float3 L = normalize(WorldSpaceLightDir(IN.vertex));

				float4 col = UNITY_LIGHTMODEL_AMBIENT;

				col += _LightColor0 * saturate(dot(N,L));

				float3 R = 2*dot(N,L)*N - L;
				float3 V = normalize(WorldSpaceViewDir(IN.vertex));
				col += _Specular * pow(saturate(dot(R,V)),_Shininess);

				col.rgb += Shade4PointLights(unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
			 							 unity_LightColor[0], unity_LightColor[1], unity_LightColor[2], unity_LightColor[3],
										 unity_4LightAtten0, normalize(mul(_Object2World,IN.vertex).xyz),N);
				
				
				col.rgb *= atten;

				
				return col;
			}
			ENDCG
		}

		pass
		{
			tags {"LightMode" = "ForwardAdd"}
			blend one one

			CGPROGRAM
			#pragma multi_compile_fwdadd_fullshadows
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "AutoLight.cginc"

			float4 _Specular;
			float _Shininess;

			struct v2f{
				float4 pos:POSITION;
				float3 normal:NORMAL;
				float4 vertex:COLOR;
				
				//unityShadowCoord3 _LightCoord : TEXCOORD0;
				//unityShadowCoord3 _ShadowCoord : TEXCOORD1;
				LIGHTING_COORDS(0,1)
			};

			v2f vert(appdata_base v)
			{
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP,v.vertex);
				o.normal = v.normal;
				o.vertex = v.vertex;

				TRANSFER_VERTEX_TO_FRAGMENT(o)
				return o;
			}

			fixed4 frag(v2f IN):COLOR
			{
				float atten = LIGHT_ATTENUATION(IN);

				float3 N = UnityObjectToWorldNormal(IN.normal);
				float3 L = normalize(WorldSpaceLightDir(IN.vertex));

				float4 col = _LightColor0 * saturate(dot(N,L));

				float3 R = 2*dot(N,L)*N - L;
				float3 V = normalize(WorldSpaceViewDir(IN.vertex));
				col += _Specular * pow(saturate(dot(R,V)),_Shininess);

				col.rgb += Shade4PointLights(unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
			 							 unity_LightColor[0], unity_LightColor[1], unity_LightColor[2], unity_LightColor[3],
										 unity_4LightAtten0, normalize(mul(_Object2World,IN.vertex).xyz),N);
				
				
				col.rgb *= atten;

				return col;
			}
			ENDCG
		}
	}
}
