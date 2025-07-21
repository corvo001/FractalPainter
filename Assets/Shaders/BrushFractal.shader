Shader "Custom/BrushFractal"
{
    Properties
    {
        _EdgeTex ("Edge Mask", 2D) = "white" {}
        _BrushSize ("Brush Size", Float) = 0.05
        _UV ("Brush Position", Vector) = (0.5, 0.5, 0, 0)
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" }
        ZWrite Off
        Blend SrcAlpha OneMinusSrcAlpha
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            sampler2D _EdgeTex;
            float4 _UV;
            float _BrushSize;

            struct v2f {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            v2f vert(appdata_base v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord;
                return o;
            }

            float4 frag(v2f i) : SV_Target
            {
                float2 delta = i.uv - _UV.xy;
                float dist = length(delta);
                
                float mask = smoothstep(_BrushSize, 0.0, dist);

                float edge = tex2D(_EdgeTex, i.uv).r;
                if (edge < 0.5) discard; // solo pintar si hay borde

                float4 color = float4(mask, mask, mask, mask);
                return color;
            }
            ENDCG
        }
    }
}
