# 🐍 Data Science & Machine Learning — Laboratorios

Implementación de los algoritmos fundamentales de aprendizaje automático, cada uno desde su mecánica interna: cómo se elige el hiperparámetro, dónde empieza el sobreajuste y qué se pierde al reducir dimensiones.

> **Nota honesta sobre los datos.** Estos siete laboratorios usan el dataset **Iris** (150 observaciones, 4 características, 3 clases). Es un conjunto de referencia clásico, deliberadamente pequeño y limpio: el objetivo aquí es **entender y comparar el comportamiento de los algoritmos**, no resolver un caso de negocio. Los casos con datos reales de empresas están en [PowerBI_Proyectos](../PowerBI_Proyectos), [Ingenieria_Proyectos](../Ingenieria_Proyectos) y [Automatizaciones_IA](../Automatizaciones_IA).

---

## 📓 Notebooks

Todos incluyen sus **salidas y gráficos renderizados**, así que se pueden leer directamente en GitHub sin ejecutar nada.

| Notebook | Algoritmo | Qué se explora en él |
| :--- | :--- | :--- |
| **[kmeans_2025_ii.ipynb](Laboratorios_ML/kmeans_2025_ii.ipynb)** | K-Means | Normalización min-max, curva de inercia para k de 1 a 20 con 50 aleatorizaciones, y validación del codo con `KElbowVisualizer` de Yellowbrick |
| **[knn_2025_II.ipynb](Laboratorios_ML/knn_2025_II.ipynb)** | K-Nearest Neighbors | Barrido de k de 1 a 20 con **100 particiones aleatorias por valor**, comparando accuracy de entrenamiento contra prueba para localizar el punto de sobreajuste |
| **[dt_2025_II.ipynb](Laboratorios_ML/dt_2025_II.ipynb)** | Árboles de decisión | Curva de profundidad de 1 a 15 con 50 repeticiones: dónde el árbol deja de generalizar y empieza a memorizar |
| **[pca_2025_ii.ipynb](Laboratorios_ML/pca_2025_ii.ipynb)** | PCA | Varianza explicada acumulada por componente y proyección a 2D para visualizar la separabilidad de clases |
| **[kfolds_2025_ii.ipynb](Laboratorios_ML/kfolds_2025_ii.ipynb)** | Validación cruzada | K-Fold como alternativa robusta al *hold-out* simple, para no depender de una sola partición |
| **[redes_neuronales.ipynb](Laboratorios_ML/redes_neuronales.ipynb)** | Redes neuronales | Red densa en TensorFlow/Keras: `LabelEncoder`, `StandardScaler` y `classification_report` con precision, recall y F1 |
| **[pickle_2025_ii.ipynb](Laboratorios_ML/pickle_2025_ii.ipynb)** | Serialización | Persistencia del modelo entrenado con Pickle para reutilizarlo sin reentrenar — el paso previo al despliegue |

---

## 🔬 Criterio metodológico

Lo que hace comparable a estos laboratorios no es el dataset, sino el método:

- **Nunca una sola partición.** Cada barrido de hiperparámetros repite el `train_test_split` entre 50 y 100 veces y promedia. Un solo split da un número; cien dan una tendencia.
- **Entrenamiento *contra* prueba, siempre en el mismo gráfico.** Es la única forma de ver el sobreajuste en lugar de suponerlo.
- **Escalado antes de cualquier modelo basado en distancia.** K-Means y KNN miden distancias: sin normalizar, la variable de mayor rango domina el resultado.

---

## 🛠️ Stack

`Python 3` · `Scikit-learn` · `TensorFlow / Keras` · `Pandas` · `NumPy` · `Matplotlib` · `Yellowbrick`

---

### ▶️ Para ejecutarlos

Los notebooks fueron desarrollados en **Google Colab** y cargan el dataset con `files.upload()`. Para correrlos localmente, sustituye esa celda por la carga directa:

```python
from sklearn.datasets import load_iris
iris = load_iris(as_frame=True).frame
```
