Shader "Custom/s31" {
	
	SubShader{
		Pass{
			CGPROGRAM
// Upgrade NOTE: excluded shader from OpenGL ES 2.0 because it uses non-square matrices
#pragma exclude_renderers gles

			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			
			typedef float4 FL4;

			//struct v2f{
			//	float4 pos;
			//	float2 uv;
			//};


			void vert(in float2 objPos:POSITION, out float4 pos:POSITION)
			{
				pos = float4(objPos,0,1);
			}

			void frag(out float4 col:COLOR)
			{
				fixed r = 1;
				fixed g = 0;
				fixed b = 0;
				fixed a = 1;
				float2 f11 = float2(0,1);
				col = FL4(f11.yy,0,1);
				
				float2x4 M2x4 = {1,0,1,0,0,1,0,1};
				float arr[4] = {0,1,1,1};
				col = FL4(arr[0],arr[1],arr[2],arr[3]);

			}

			ENDCG
		}
	}
}
