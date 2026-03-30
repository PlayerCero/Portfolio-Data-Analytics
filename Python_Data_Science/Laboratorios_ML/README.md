# 🤖 Data Science & Machine Learning: Modelado Predictivo y Clasificación

Este repositorio contiene la implementación de diversos algoritmos de Aprendizaje Automático (Machine Learning), enfocados en la resolución de problemas de clasificación, regresión y agrupamiento (clustering) aplicados al análisis de datos industriales y de negocios.

## 📂 Algoritmos e Implementaciones

| Algoritmo / Módulo | Carpeta del Proyecto | Herramientas Clave | Aplicación y Objetivo |
| :--- | :--- | :--- | :--- |
| **K-Means Clustering** | `01_Kmeans` | Scikit-learn, Matplotlib | Segmentación de datos no etiquetados para identificación de patrones y grupos. |
| **K-Nearest Neighbors** | `02_Knn` | Scikit-learn, NumPy | Clasificación supervisada basada en la proximidad y similitud de características. |
| **Arboles de Decisión** | `03_DecisionTree` | Scikit-learn, Graphviz | Modelado de reglas de decisión jerárquicas para predicción de categorías. |
| **PCA (Análisis de Componentes)** | `04_PCA` | Scikit-learn, Pandas | Reducción de dimensionalidad para visualización y optimización de modelos. |
| **Redes Neuronales** | `05_NeuralNetworks` | TensorFlow / Keras | Implementación de modelos de Deep Learning para patrones complejos no lineales. |
| **Validación Cruzada** | `06_Kfolds` | K-Fold Cross Validation | Evaluación robusta del rendimiento de los modelos para mitigar el sobreajuste (overfitting). |
| **Persistencia de Modelos** | `07_Pickle` | Pickle Library | Serialización y almacenamiento de modelos entrenados para su despliegue en producción. |

---

### 🛠️ Stack Tecnológico
* **Lenguaje:** Python 3.x
* **Librerías de ML:** Scikit-learn, TensorFlow, Keras.
* **Manipulación de Datos:** Pandas, NumPy.
* **Visualización:** Matplotlib, Seaborn.

### 📈 Metodología de Trabajo
Cada notebook sigue un flujo de trabajo de Ciencia de Datos estándar:
1. **EDA (Análisis Exploratorio):** Limpieza y comprensión de la distribución de los datos.
2. **Preprocesamiento:** Escalado de variables, codificación y reducción de dimensionalidad (PCA).
3. **Entrenamiento:** Ajuste de hiperparámetros y selección del modelo óptimo.
4. **Validación:** Uso de métricas como Accuracy, Precision, Recall y validación cruzada (K-Folds).

---
