Shader "UUG/DiffuseNormal" 
{
	Properties 
	{
		_Diffuse("Diffuse Texture", 2D) = "white"{}
		_Bump("Normal Texture", 2D) = "bump"{}
		_BumpAmount("Bump Amount", Range(0, 10)) = 1
		_lightAmount("Light Amount", Range(0, 10)) = 1
	}
	SubShader
	{

		CGPROGRAM

			#pragma surface surf Lambert

			sampler2D _Diffuse;
			sampler2D _Bump;
			half _BumpAmount;
			half _lightAmount;

			struct Input 
			{
				float2 uv_Diffuse;
				float2 uv_Bump;
			};

			void surf(Input IN, inout SurfaceOutput o) {
				o.Albedo = tex2D(_Diffuse, IN.uv_Diffuse).rgb;
				o.Normal = UnpackNormal(tex2D(_Bump, IN.uv_Bump)) * _lightAmount;
				o.Normal *= float3(_BumpAmount, _BumpAmount, 1);
			}
		ENDCG
	}
	FallBack "Diffuse"
}
