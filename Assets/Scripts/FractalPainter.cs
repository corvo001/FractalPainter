
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.InputSystem;

public class FractalPainter : MonoBehaviour
{
    public RawImage backgroundImage;
    public RawImage drawingLayer;
    public Shader brushShader;

    private RenderTexture drawingTexture;
    private Material brushMaterial;
    private Camera cam;

    void Start()
    {
        cam = Camera.main;

        drawingTexture = new RenderTexture(1024, 1024, 0);
        drawingTexture.Create();
        drawingLayer.texture = drawingTexture;

        brushMaterial = new Material(brushShader);
        DrawAtUV(new Vector2(0.5f, 0.5f)); // pintar inicial
    }

    void Update()
    {
        if (Mouse.current != null && Mouse.current.leftButton.isPressed)
        {
            Vector2 screenPos = Mouse.current.position.ReadValue();

            Vector2 localPoint;
            if (RectTransformUtility.ScreenPointToLocalPointInRectangle(
                drawingLayer.rectTransform,
                screenPos,
                null,
                out localPoint))
            {
                Rect rect = drawingLayer.rectTransform.rect;

                Vector2 uv = new Vector2(
                    Mathf.Clamp01((localPoint.x + rect.width / 2) / rect.width),
                    Mathf.Clamp01((localPoint.y + rect.height / 2) / rect.height)
                );

                DrawAtUV(uv);
            }
        }
    }

    void DrawAtUV(Vector2 uv)
    {
        if (brushMaterial == null) return;

        RenderTexture.active = drawingTexture;

        brushMaterial.SetVector("_UV", uv);
        brushMaterial.SetFloat("_TimeSeed", Time.time);
        Graphics.Blit(null, drawingTexture, brushMaterial);

        RenderTexture.active = null;
    }
}
