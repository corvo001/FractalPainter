using UnityEngine;
using UnityEngine.UI;

public class EdgeFractalPainter : MonoBehaviour
{
    [Header("UI y texturas")]
    public RawImage screenDisplay;
    public Texture2D baseImage;

    [Header("Materiales")]
    public Material edgeDetectMaterial;
    public Material brushFractalMaterial;

    [Header("Pintura")] 
    public float brushSize = 0.05f;
    private RenderTexture drawTexture;
    private RenderTexture edgeTexture;
    private Vector2 paintUV;

    void Start()
    {
        if (baseImage == null || screenDisplay == null || edgeDetectMaterial == null || brushFractalMaterial == null)
        {
            Debug.LogError("Faltan referencias en EdgeFractalPainter");
            return;
        }

        // Crear RT para bordes
        edgeTexture = new RenderTexture(baseImage.width, baseImage.height, 0);
        Graphics.Blit(baseImage, edgeTexture, edgeDetectMaterial);

        // Crear RT donde se pinta
        drawTexture = new RenderTexture(baseImage.width, baseImage.height, 0);
        Graphics.Blit(baseImage, drawTexture); // Copia inicial

        // Asignar RT final a UI
        screenDisplay.texture = drawTexture;

        // Asignar textura de bordes al shader de brocha
        brushFractalMaterial.SetTexture("_EdgeTex", edgeTexture);
    }

    void Update()
    {
        if (Input.GetMouseButton(0))
        {
            Vector2 mousePos = Input.mousePosition;
            RectTransform rect = screenDisplay.rectTransform;

            Vector2 localPoint;
            RectTransformUtility.ScreenPointToLocalPointInRectangle(rect, mousePos, null, out localPoint);

            Vector2 normalizedUV = new Vector2(
                (localPoint.x + rect.rect.width * 0.5f) / rect.rect.width,
                (localPoint.y + rect.rect.height * 0.5f) / rect.rect.height);

            paintUV = normalizedUV;

            // Pintar fractalmente en drawTexture guiado por edgeTexture
            brushFractalMaterial.SetVector("_UV", new Vector4(paintUV.x, paintUV.y, 0, 0));
            brushFractalMaterial.SetFloat("_BrushSize", brushSize);

            RenderTexture temp = RenderTexture.GetTemporary(drawTexture.width, drawTexture.height);
            Graphics.Blit(drawTexture, temp);
            Graphics.Blit(temp, drawTexture, brushFractalMaterial);
            RenderTexture.ReleaseTemporary(temp);
        }
    }
}