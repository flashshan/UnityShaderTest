Shader "Custom/s11" {
	Properties{
		_Color("Color",color) = (1,1,1,1)
		_Ambient("Ambient",color) = (0.3,0.3,0.3,0.3)
		_Specular("Specular",color) = (1,1,1,1)
		_Shininess("Shininess",Range(0,8)) = 4
		_Emission("Emission",color) = (0,0,0,0)
	}

	SubShader{
		pass{

			Material{
				diffuse[_Color]
				ambient[_Ambient]
				specular[_Specular]
				shininess[_Shininess]
				emission[_Emission]
			}
			Lighting on
			SeparateSpecular on
		}
	}
}
