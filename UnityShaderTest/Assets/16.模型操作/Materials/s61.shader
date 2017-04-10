Shader "Custom/s61" {
	Properties {
		_MainColor ("Main Color", Color) = (1,1,1,1)
		_Specular("Specular",color) = (1,1,1,1)
		_Shininess("Shininess", Range(0,20)) = 3
	}
	SubShader {
		Tags { "LightMode" = "ForwardBase" }
		
		Pass{
		
			CGPROGRAM
			#pragma multi_compile_fwdbase
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "AutoLight.cginc"

			float4 _MainColor;
			float4 _Specular;
			float _Shininess;

			struct v2f{
				float4 pos:POSITION;
				float3 normal:NORMAL;
				float4 vertex:COLOR;
				LIGHTING_COORDS(0,1)
			};

			v2f vert(appdata_base v)
			{
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.normal = v.normal;
				o.vertex = v.vertex;
				TRANSFER_VERTEX_TO_FRAGMENT(o)
				return o;
			}

			fixed4 frag(v2f IN):Color
			{
				float3 N = UnityObjectToWorldNormal(IN.normal);
				float3 L = normalize(WorldSpaceLightDir(IN.vertex));

				fixed4 col = UNITY_LIGHTMODEL_AMBIENT;

				col += _LightColor0 * saturate(dot(N,L));

				float3 R = 2* dot(L,N) *N - L;
				float3 V = normalize(WorldSpaceViewDir(IN.vertex));
				col += _Specular * pow(saturate(dot(R,V)),_Shininess);

				col.rgb += Shade4PointLights(unity_4LightPosX0,unity_4LightPosY0,unity_4LightPosZ0,
											 unity_LightColor[0], unity_LightColor[1], unity_LightColor[2],unity_LightColor[3],
											 unity_4LightAtten0, normalize(mul(_Object2World, IN.vertex).xyz), N);

				float atten = LIGHT_ATTENUATION(IN);
				col.rgb *= atten * _MainColor;

				
				return col;
			}

			ENDCG
		}
	}
}
