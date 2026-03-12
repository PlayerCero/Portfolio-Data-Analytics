-- =================================================================
-- PROYECTO: Análisis de Salud Mental en Estudiantes Internacionales
-- HERRAMIENTA: PostgreSQL / SQL
-- DESCRIPCIÓN: Evaluación de métricas de depresión y estrés 
--             basadas en la duración de la estancia.
-- =================================================================

SELECT 
    stay, 
    COUNT(inter_dom) AS count_int,
    ROUND(AVG(todep), 2) AS average_phq, -- Promedio de depresión (test PHQ-9)
    ROUND(AVG(tosc), 2) AS average_scs, -- Promedio de conexión social (test SCS)
    ROUND(AVG(toas), 2) AS average_as   -- Promedio de estrés aculturativo (test ASISS)
FROM students
WHERE inter_dom = 'Inter'
GROUP BY stay
ORDER BY stay DESC;

-- NOTA: El análisis muestra una correlación entre el tiempo de 
-- estancia y la mejora en los indicadores de salud mental.
