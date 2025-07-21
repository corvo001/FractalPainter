Shader "Custom/EdgeDetect"
{
    Properties
    {
        _MainTex ("Source Image", 2D) = "white" {}
        _Threshold ("Edge Threshold", Range(0, 1)) = 0.2
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            sampler2D _MainTex;
            float4 _MainTex_TexelSize;
            float _Threshold;

            struct v2f {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            v2f vert(appdata_base v) {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord;
                return o;
            }

            float4 frag(v2f i) : SV_Target {
                float3 gx = 0;
                float3 gy = 0;

                float2 offset = _MainTex_TexelSize.xy;

                gx += tex2D(_MainTex, i.uv + float2(-offset.x, -offset.y)).rgb * -1.0;
                gx += tex2D(_MainTex, i.uv + float2(-offset.x,  offset.y)).rgb * -1.0;
                gx += tex2D(_MainTex, i.uv + float2( offset.x, -offset.y)).rgb *  1.0;
                gx += tex2D(_MainTex, i.uv + float2( offset.x,  offset.y)).rgb *  1.0;

                gy += tex2D(_MainTex, i.uv + float2(-offset.x, -offset.y)).rgb * -1.0;
                gy += tex2D(_MainTex, i.uv + float2( offset.x, -offset.y)).rgb * -1.0;
                gy += tex2D(_MainTex, i.uv + float2(-offset.x,  offset.y)).rgb *  1.0;
                gy += tex2D(_MainTex, i.uv + float2( offset.x,  offset.y)).rgb *  1.0;

                float edge = length(gx + gy);
                edge = edge > _Threshold ? 1.0 : 0.0;

                return float4(edge, edge, edge, 1.0);
            }
            ENDCG
        }
    }
}
