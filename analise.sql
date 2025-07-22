-- Entendendo a base de dados

SELECT * FROM trips LIMIT 10;

-- Quantas corridas nós temos?

SELECT COUNT(DISTINCT id) AS qtd_corridas_total FROM trips
WHERE duration >= (60 * 5);

-- Qual o tempo médio dessa corridas?

SELECT
	COUNT(DISTINCT id) AS qtd_corridas_total,
	MIN(duration) / 60 AS menor_tempo,
	AVG(duration) / 60 AS tempo_medio,
	MAX(duration) / 60 AS maior_tempo,
	STDEV(duration) AS desvio_padrao -- Se não funcionar use: sqrt(AVG(duration * duration) - AVG(duration) * AVG(duration)) AS desvio_padrao
FROM trips
WHERE duration >= (60 * 5) AND duration <= 500000;

-- Quais o nosso melhor mês?

SELECT
	SUBSTR(start_date, 1, 7) AS year_month,
	COUNT(DISTINCT id) AS qtd_corridas_total
FROM trips
WHERE duration >= (60 * 5) AND duration <= 500000
GROUP BY year_month
ORDER BY qtd_corridas_total DESC
LIMIT 1;

-- Quais os top 5 horários de pico?

SELECT
	SUBSTR(start_date, 12, 2) AS hour,
	duration,
	COUNT(DISTINCT id) AS qtd_corridas_total
FROM trips
WHERE duration >= (60 * 5) 
AND duration <= 500000 
AND SUBSTR(start_date, 1, 7) = '2014-10'
GROUP BY hour
ORDER BY qtd_corridas_total DESC
LIMIT 5;
