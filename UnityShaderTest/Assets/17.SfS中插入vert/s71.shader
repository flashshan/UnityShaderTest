Shader "Custom/s31" {
	Properties {
		 
		_MainColor("MainColor", color) = (1,1,1,1)
		_SecondColor("SecondColor",color) = (1,1,1,1)
		_Glossiness("Smoothness", Range(0,1)) = 0.5
		_Metallic("Metallic",Range(0,1)) = 0.0
		_Center("Center",Range(-0.51,0.51)) = 0
		_Length("Length", Range(0,1)) = 0
	}
	SubShader {
		Tags{"RenderType" = "Opaque"}
		
		CGPROGRAM
		#pragma surface surf Standard vertex:vert fullforwardshadows
		#pragma target 3.0

		float4 _MainColor;
		float4 _SecondColor;
		float _Center;
		float _Glossiness;
		float _Metallic;
		float _Length;

		struct Input{
			float2 uv_MainTex;
			float4 vertex; 
		};

		void vert(inout appdata_full v, out Input o)
		{
			o.uv_MainTex = v.texcoord.xy;
			o.vertex = v.vertex;
		}


		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			float d = IN.vertex.x - _Center;
			o.Albedo = lerp(_SecondColor,_MainColor,saturate(2 * d/_Length + 1));

			o.Smoothness = _Glossiness;
			o.Metallic = _Metallic;
			o.Alpha = 1;
		}

		ENDCG
		
	}
	//FallBack "Diffuse"
}
