
Shader "Custom/BrushShaderFractal"
{
    Properties
    {
        _UV("Draw Position", Vector) = (0.5, 0.5, 0, 0)
        _TimeSeed("Time Seed", Float) = 0
    }
    SubShader
    {
        Tags { "RenderType" = "Opaque" }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            float4 _UV;
            float _TimeSeed;

            struct appdata { float4 vertex : POSITION; float2 uv : TEXCOORD0; };
            struct v2f { float2 uv : TEXCOORD0; float4 vertex : SV_POSITION; };

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            float fractalPattern(float2 z)
            {
                float2 c = _UV.xy * 2.0 - 1.0;
                int iterations = 10;
                float escape = 0.0;
                for (int i = 0; i < iterations; i++)
                {
                    z = float2(z.x * z.x - z.y * z.y, 2 * z.x * z.y) + c;
                    if (dot(z, z) > 4.0) break;
                    escape += 1.0;
                }
                return escape / iterations;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float2 pos = i.uv;
                float d = distance(pos, _UV.xy);
                float f = fractalPattern(pos * 2.0 - 1.0);
                float alpha = smoothstep(0.2, 0.0, d) * f;
                return fixed4(f, f * 0.5, 1 - f, alpha);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
