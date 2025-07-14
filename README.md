#  Fractal Painter

Fractal Painter es una aplicación interactiva para crear arte visual basado en fractales en tiempo real.  
Cada trazo que realizas genera un patrón fractal único controlado por shaders, permitiéndote pintar no con líneas, sino con estructuras matemáticas.

---

##  Características principales

-  Pintura en tiempo real usando shaders fractales (Mandelbrot/Julia)
-  Interfaz simple sobre `Canvas` con `RawImage` y `RenderTexture`
-  Input compatible con el nuevo Input System de Unity
-  Cada trazo es un cálculo fractal posicionado en coordenadas UV
-  Compatible con extensiones: pinceles mutantes, exportación, IA, etc.

---

##  Filosofía

Este proyecto no trata de imitar pintura tradicional, sino de redefinirla:

> *"No dibujas en la pantalla. Dibuja la pantalla en sí misma."*

La interacción genera trazos basados en fórmulas fractales, mutables, pulsantes y sensibles al tiempo.  
Es arte algorítmico vivo, controlado por tu intuición y multiplicado por la matemática visual.

---

##  Estructura del proyecto
Assets/
├── FractalPainter/
│ ├── FractalPainter.cs # Script principal
│ ├── BrushShaderFractal.shader # Shader fractal reactivo
│ └── (opcional) BrushMaterial.mat # Material que usa el shader

---

## 🛠 Requisitos

- Unity 2021.3 o superior (recomendado: Unity 2022+)
- ✅ `Canvas` en modo `Screen Space - Overlay`
- ✅ Nuevo Input System activado (`Mouse.current`)
- ✅ Shader funcional asignado en el Inspector del script

---

##  Instrucciones de uso

1. Abre el proyecto en Unity
2. Crea una escena vacía o abre `MainScene.unity`
3. Añade un `Canvas` con dos `RawImage`: uno de fondo y uno de dibujo
4. Asigna el script `FractalPainter.cs` a un GameObject vacío
5. En el Inspector, enlaza:
   - `BackgroundImage` → RawImage de fondo
   - `DrawingLayer` → RawImage sobre el que se pinta
   - `Brush Shader` → Shader `BrushShaderFractal`
6. Pulsa ▶ y empieza a pintar con el ratón

---

##  Funcionalidad avanzada (próxima)

- [ ] Exportar a PNG
- [ ] Galería de presets generados
- [ ] Mutaciones fractales automáticas
- [ ] Pinceles adaptativos o caóticos
- [ ] IA que aprenda del trazo visual y genere nuevas formas

---

##  Exportación

Se puede implementar fácilmente un sistema de exportación con:

```csharp
Texture2D tex = new Texture2D(width, height, TextureFormat.RGB24, false);
RenderTexture.active = drawingTexture;
tex.ReadPixels(new Rect(0, 0, width, height), 0, 0);
tex.Apply();
// Luego: File.WriteAllBytes(path, tex.EncodeToPNG());
