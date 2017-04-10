Shader "Custom/s01" {
	Properties{
		_Specular("Specular",color) = (1,1,1,1)
		_Shininess("Shininess", Range(1,20)) = 4 
	}

	SubShader {
		Pass{
			Tags{ "LightMode" = "ForwardBase"}
			CGPROGRAM
			#pragma multi_compile_fwdbase
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include "Lighting.cginc"

			struct v2f {
				float4 pos:POSITION;
				fixed4 col:COLOR;
			};
			
			float4 _Specular;
			float _Shininess;

			//光照 = 环境光 + 漫反射 + 镜面反射
			v2f vert(appdata_base v)
			{
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				//o.col = fixed4(0,0,1,1);
				
				//漫反射
				//改变光向量到物体坐标
				float3 N = normalize(v.normal);
				float3 L = normalize(_WorldSpaceLightPos0);

				//对于非等比缩放，不能将法向量放到世界坐标空间中,也不能将光照转到模型坐标中来 
				//N = normalize(mul(_Object2World, float4(N,0)));
				//L= normalize(mul(_World2Object, float4(L,0)).xyz);

				N = normalize(mul(float4(N,0),_World2Object).xyz);
				

				float NdotL = saturate(dot(N,L));
				o.col = _LightColor0 * NdotL;

				//vertex光照渲染模式
				//o.col.rgb = ShadeVertexLights(v.vertex,v.normal);

				//ForwardBase渲染模式下的最多4个点光源的渲染
				o.col.rgb += Shade4PointLights(unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
							                   unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
											   unity_4LightAtten0, mul(_Object2World, v.vertex).xyz,N); 
				
				return o;

			}

			fixed4 frag(v2f IN) :COLOR
			{
				return IN.col + UNITY_LIGHTMODEL_AMBIENT; 				
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
