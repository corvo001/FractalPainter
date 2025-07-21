# FractalPainter v0.3 — Pintura Fractal Guiada por Contornos

![screenshot](./preview.png)

**FractalPainter v0.3** es una herramienta experimental construida en Unity que permite pintar con trazos fractales sobre los contornos detectados de una imagen base. Los bordes son detectados mediante un shader Sobel, y la pintura solo se activa en esas zonas, generando patrones fractales guiados visualmente por la estructura de la imagen.

---

##  Características

-  Pintura visual con brocha fractal interactiva
-  Detección de bordes en tiempo real usando shader Sobel
-  Soporte para cualquier imagen en blanco y negro como base
-  Control por ratón: solo se pinta donde hay bordes
-  Arquitectura modular: lista para integrar shaders o partículas avanzadas

---

##  Estructura Técnica

- `EdgeDetect.shader` → Shader Sobel que genera la textura de contornos
- `BrushFractal.shader` → Shader de brocha que pinta fractalmente guiado por los bordes
- `EdgeFractalPainter.cs` → Script principal que gestiona el flujo de imagen, detección y pintura

---

##  Requisitos

- Unity 2021.3+ (URP o Built-in)
- Input System clásico activado (`Edit > Project Settings > Player > Active Input Handling → Both`)

---

##  Instrucciones

1. Abre el proyecto en Unity
2. Asigna tu imagen base a `baseImage` en el componente `EdgeFractalPainter`
3. Asigna los materiales `Mat_EdgeDetect` y `Mat_BrushFractal`
4. Ejecuta la escena
5. Mantén presionado el botón izquierdo del ratón y dibuja sobre los bordes detectados

---

##  Archivos clave

```
Assets/
├── Shaders/
│   ├── EdgeDetect.shader
│   └── BrushFractal.shader
├── Scripts/
│   └── EdgeFractalPainter.cs
├── Materials/
│   ├── Mat_EdgeDetect.mat
│   └── Mat_BrushFractal.mat
└── Resources/
    └── imagenBase.png
```

---

##  Roadmap

- [ ] Guardado en PNG de los resultados
- [ ] Soporte para carga dinámica de imágenes
- [ ] Brochas animadas y deformables con partículas
- [ ] Control táctil y gestos en versión móvil

---

##  Autor

Desarrollado por **Cuervo** como experimento de pintura visual fractal interactiva.

---

##  Licencia

MIT — libre para modificar y distribuir. Credita al autor si usas el sistema en tus proyectos.
