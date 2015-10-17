Shader ".Tutorial/Fixed Unlit"
{
	Properties
	{
		_Color("Diffuse Color", Color) = (1, 1, 1, 1)
		_Ka("Ambient Light", Vector) = (0.3, 0.3, 0.3)
		_Shininess("Shininess", Float) = 1000
	}

	SubShader
	{
		Pass
		{
		CGPROGRAM
		#pragma vertex vert	
		#pragma fragment frag

		struct appdata
		{
			float4 vertex : POSITION;
			float3 normal : NORMAL;
			float2 texcoord : TEXCOORD0;
		};

		struct v2f
		{
			float4 pos : SV_POSITION;
			float3 normal : NORMAL;
			float2 texcoord: TEXCOORD0;
		};

		fixed4 _Color;
		float4 _LightColor0;
		sampler2D _MainTex;
		float4 _Ka;
		float _Shininess;

		v2f vert(appdata IN)
		{
			v2f OUT;
			OUT.pos = mul(UNITY_MATRIX_MVP, IN.vertex);
			OUT.texcoord = IN.texcoord;
			OUT.normal = mul(float4(IN.normal, 0.0), _Object2World).xyz; 
			return OUT;
		}

		fixed4 frag(v2f IN) : COLOR
		{
			float3 N = normalize(IN.normal);
			float3 L = normalize(_WorldSpaceLightPos0);
			float3 V = normalize(_WorldSpaceCameraPos - IN.pos.xyz);
			float3 R = 2 * max(0.0, dot(N, L)) * N - L;

			float Kd = _Color.xyz * max(0.0, dot(N, L));
			float Ks = pow(max(0.0, max(0.0, dot(R, V))), _Shininess);

			float4 Illumination = Kd + Ks + _Ka;

			return _LightColor0*Illumination;
		}

		ENDCG
		}
	}
}