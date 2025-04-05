
-- Questão 1. Gere uma lista de todos os instrutores, mostrando sua ID, nome e número de seções que eles ministraram.
-- Não se esqueça de mostrar o número de seções como 0 para os instrutores que não ministraram qualquer seção.
--- Sua consulta deverá utilizar outer join e não deverá utilizar subconsultas escalares.


select i.id, i.name, count(s.sec_id) as Number_f_sections
from instructor i 
full outer join teaches as t 
on i.id = t.id full outer join 
section as s 
on t.sec_id = s.sec_id and t.course_id = s.course_id
group by i.id, i.name


--Escreva a mesma consulta do item anterior, mas usando uma subconsulta escalar, sem outer join.

SELECT 
   i.id, 
 i.name,
    (
        SELECT COUNT(*) 
        FROM teaches as t, section as s
        WHERE t.id = i.id
          AND t.sec_id = s.sec_id 
          AND t.course_id = s.course_id
    ) AS Number_of_sections
FROM instructor as i;



---Questão 3. Gere a lista de todas as seções de curso oferecidas na primavera de 2010, 
---junto com o nome dos instrutores ministrando a seção. Se uma seção tiver mais de 1 instrutor, 
-- ela deverá aparecer uma vez no resultado para cada instrutor.
---Se não tiver instrutor algum, ela ainda deverá aparecer no resultado, com o nome do instrutor definido como “-”.


select top 10 * from section

select distinct s.course_id, s.sec_id, i.id, s.semester, s.year, i.name
from section as s left join teaches as t
on s.course_id = t.course_id inner join
instructor as i on t.id = i.id 
where s.semester = 'Spring' and s.[year] = 2010



--Questão 4. Suponha que você tenha recebido uma relação grade_points (grade, points), que oferece uma 
--conversão de conceitos (letras) na relação takes para notas numéricas;
-- por exemplo, uma nota “A+” poderia ser especificada para corresponder a 4 pontos,
-- um “A” para 3,7 pontos, e “A-” para 3,4, e “B+” para 3,1 pontos, e assim por diante. 
--Os Pontos totais obtidos por um aluno para uma oferta de curso (section)

--são definidos como o número de créditos para o curso multiplicado pelos pontos numéricos para a nota que
--o aluno recebeu.
--Dada essa relação e o nosso esquema university, escreva: 
--Ache os pontos totais recebidos por aluno, para todos os cursos realizados por ele.

select top 10 * from takes

select top 10 *  from student

SELECT 
    st.id, 
    st.name, 
    c.title,
    st.dept_name, 
    t.grade,
    (CASE
        WHEN t.grade = 'A+' THEN 4.0
        WHEN t.grade = 'A'  THEN 3.7
        WHEN t.grade = 'A-' THEN 3.4
        WHEN t.grade = 'B+' THEN 3.1
        WHEN t.grade = 'B'  THEN 2.8
        WHEN t.grade = 'B-' THEN 2.5
        WHEN t.grade = 'C+' THEN 2.0
        WHEN t.grade = 'C'  THEN 1.7
        WHEN t.grade = 'C-' THEN 1.4
        ELSE 0.0
    END) AS points,
    c.credits,
   (CASE
        WHEN t.grade = 'A+' THEN 4.0
        WHEN t.grade = 'A'  THEN 3.7
        WHEN t.grade = 'A-' THEN 3.4
        WHEN t.grade = 'B+' THEN 3.1
        WHEN t.grade = 'B'  THEN 2.8
        WHEN t.grade = 'B-' THEN 2.5
        WHEN t.grade = 'C+' THEN 2.0
        WHEN t.grade = 'C'  THEN 1.7
        WHEN t.grade = 'C-' THEN 1.4
        ELSE 0.0
    END * c.credits) AS pontos_totais
FROM student AS st
JOIN takes AS t ON st.id = t.id
JOIN section AS s ON t.course_id = s.course_id and t.sec_id = s.sec_id
join course as c on s.course_id = c.course_id

