Shader "Custom/s12" {
	Properties{
		_Color("Color",color) = (1,1,1,1)
		_Ambient("Ambient",color) =(0.3,0.3,0.3,0.3)
		_Specular("Specular",color) = (1,1,1,1)
		_Shininess("Shininess",Range(0,8)) = 4
		_Emission("Emission",color) = (0,0,0,0)
		_Constant("ConstantColor",color) = (1,1,1,0.3) 
		_MainTex("Main Tex", 2D) = ""
		_SecondTex("Second Tex", 2D) = ""
	}
	
	SubShader{
		Tags{"Queue" = "transparent"}
		Pass{
			Blend SrcAlpha OneMinusSrcAlpha
			Material{
				diffuse[_Color]
				ambient[_Ambient]
				specular[_Specular]
				shininess[_Shininess]
				emission[_Emission]
			}
			Lighting on
			SeparateSpecular on

			SetTexture[_MainTex]
			{
				
				combine texture * primary double
			}

			SetTexture[_SecondTex]
			{
				constantColor[_Constant]
				combine texture * primary double, texture * constant
			}
		}
	}				
			
}
