CREATE OR REPLACE FUNCTION relatorio_diario()
RETURNS TABLE (data date, total_produtos int)
AS $$
BEGIN
    -- Criação de uma tabela temporária para armazenar o resultado do relatório
    CREATE TEMP TABLE relatorio_temp AS
        SELECT
            data,
            SUM(quantidade) AS total_produtos
        FROM
            vendas
        GROUP BY
            data;

    -- Preenche o resultado da tabela temporária
    FOR data, total_produtos IN SELECT * FROM relatorio_temp
    LOOP
        -- Retorna cada linha do relatório
        RETURN NEXT;
    END LOOP;

    -- Remover a tabela temporária ao final
    DROP TABLE IF EXISTS relatorio_temp;
END;
$$ LANGUAGE plpgsql;
