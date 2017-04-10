Shader "Custom/s11" {
	Properties{
		_Specular("Specular",color) = (1,1,1,1)
		_Shininess("Shininess",Range(1,20)) = 4
	}
	SubShader {
		Tags { "LightMode"="ForwardBase" }
		
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
				fixed4 col:COLOR;
			};

			v2f vert(appdata_base v)
			{
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP,v.vertex);

				//Ambient Light
				o.col = UNITY_LIGHTMODEL_AMBIENT;

				//Diffuse Light
				//float3 N = normalize(mul(float4(v.normal,0),_World2Object).xyz);
				//用Unity中的函数计算N
				float3 N = UnityObjectToWorldNormal(v.normal); 
				float3 L = normalize(_WorldSpaceLightPos0);
				o.col += _LightColor0 * saturate(dot(N,L));

				//Specular Light    Phone模型，需要两次计算点积，比较慢
				////float3 I = normalize(mul(_Object2World,v.vertex).xyz - _WorldSpaceLightPos0);
				////float3 R = normalize(reflect(I,N));
				
				////R = 2 * Dot(N,L) * N - L;
				//float3 R = normalize(2 * dot(N,L) * N -L);

				//float3 V = normalize(WorldSpaceViewDir(v.vertex));
				//o.col = _Specular * pow(saturate(dot(R,V)),_Shininess);

				//Blin-Phone 半角模型，避免了第一次求点积的过程 dot(N,L),直接用V,L相加得半角向量，更快模拟
				 float3 V = normalize(WorldSpaceViewDir(v.vertex));
				 float3 H = normalize(L+V);
				 o.col = _Specular * pow(saturate(dot(H,N)),_Shininess);

  				 return o;
			}

			fixed4 frag(v2f IN):Color
			{
				return IN.col;
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
