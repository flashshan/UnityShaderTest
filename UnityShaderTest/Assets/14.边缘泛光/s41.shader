Shader "Custom/s41" {
	Properties {
		_MainColor("Main Color",color) = (1,1,1,1)
		_Scale1("Scale1",Range(0,8)) = 1
		_Scale2("Scale2",Range(0,8)) = 0.5 
		_Outer("Outer", Range(0,2)) = 0.1
	}
	SubShader {
		Tags { "Queue" = "Transparent"}
		
		//外部泛光
		Pass{
			blend srcAlpha OneMinusSrcAlpha
			zwrite off

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			
			float4 _MainColor;
			float _Scale1;
			float _Outer;

			struct v2f{
				float4 pos:POSITION;
				float3 normal:NORMAL;
				float4 vertex:COLOR;

			};
	
			v2f vert(appdata_base v)
			{
				v2f o;
				//o.vertex.xyz = v.vertex.xyz + _Outer * v.normal;
				//o.vertex.w = 1;
				v.vertex.xyz += _Outer * v.normal;
				o.pos = mul(UNITY_MATRIX_MVP,v.vertex);
				o.vertex = v.vertex;
				o.normal = v.normal;
				return o;
			}	


			fixed4 frag(v2f IN):COLOR
			{		
				float3 N = normalize(mul(IN.normal, (float3x3)_World2Object));

				float3 wpos = normalize(mul(_Object2World,IN.vertex).xyz);
				float3 V = normalize(_WorldSpaceCameraPos.xyz - wpos);

				float bright = saturate(dot(N,V));

				_MainColor.a *= pow(bright,_Scale1);
				return _MainColor;
				//return fixed4(1,1,1,1) * pow(bright, _Scale);
			}
			ENDCG
		}

		//外部泛光的中心颜色去除
		Pass{
			blendop revsub
			blend dstAlpha one
			//blend srcAlpha oneMinussrcAlpha
			

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			
			float _Scale;

			struct v2f{
				float4 pos:POSITION;
			};
	
			v2f vert(appdata_base v)
			{
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP,v.vertex);
				return o;
			}	

			fixed4 frag(v2f IN):COLOR
			{		
				return fixed4(1,1,1,1);
			}

			ENDCG
		}

		//内部泛光
		Pass{
			blend srcAlpha oneMinussrcAlpha

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			
			float _Scale2;

			struct v2f{
				float4 pos:POSITION;
				float3 normal:NORMAL;
				float4 vertex:COLOR;

			};
	
			v2f vert(appdata_base v)
			{
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP,v.vertex);
				o.normal = v.normal;
				o.vertex = v.vertex;
				return o;
			}	


			fixed4 frag(v2f IN):COLOR
			{		
				//内部泛光
				//float3 N = UnityObjectToWorldNormal(IN.normal);
				float3 N = normalize(mul(IN.normal, (float3x3)_World2Object));

				float3 wpos = normalize(mul(_Object2World,IN.vertex).xyz);
				float3 V = normalize(_WorldSpaceCameraPos.xyz - wpos);

				float bright = 1.0 - saturate(dot(N,V));
				//bright = saturate(1.1 * bright - 0.1);
				return fixed4(1,1,1,1) * pow(bright,_Scale2);

			}

			ENDCG
		}
	}
	FallBack "Diffuse"
}
