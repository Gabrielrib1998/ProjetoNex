<?php
// Inclui o cabeçalho do seu site (menu, etc.)
include 'templates/header.php';
// Inclui o arquivo de conexão com o banco de dados
include 'db_connect.php';
?>

<div class="content-wrapper">
    <div class="container">
        <section class="offers-page-section">
            <h2 class="section-title-highlight">Todos os Produtos em Oferta</h2>
            <div class="product-grid">
                <?php
                // 1. A consulta SQL agora busca TODOS os produtos onde 'em_oferta' é 1 (sem o LIMIT 4)
                $sql_ofertas = "SELECT * FROM produtos WHERE em_oferta = 1";
                $result_ofertas = $conn->query($sql_ofertas);

                // 2. Verifica se a consulta encontrou algum produto em oferta
                if ($result_ofertas && $result_ofertas->num_rows > 0) {
                    // 3. Loop para exibir cada produto encontrado
                    while ($row = $result_ofertas->fetch_assoc()) {
                        echo '<div class="product-card">';
                        echo '  <a href="produto.php?id=' . $row["id"] . '">';
                        echo '      <div class="product-image-container">';
                        // Supondo que você tenha uma imagem para cada produto
                        echo '<img src="' . $row["imagem_url"] . '" alt="' . $row["nome"] . '">';
                        echo '      </div>';
                        echo '      <h5>' . $row["nome"] . '</h5>';
                        // Lógica para mostrar o preço antigo riscado e o novo preço
                        if (!empty($row["preco_antigo"])) {
                            echo '      <p class="price-old">R$ ' . number_format($row["preco_antigo"], 2, ',', '.') . '</p>';
                        }
                        echo '      <p class="price-new">R$ ' . number_format($row["preco"], 2, ',', '.') . '</p>';
                        echo '  </a>';
                        // Formulário para adicionar ao carrinho
                        echo '  <form action="carrinho_acoes.php" method="post">';
                        echo '      <input type="hidden" name="produto_id" value="' . $row["id"] . '">';
                        echo '      <button type="submit" name="add_to_cart" class="btn btn-primary">Adicionar ao Carrinho</button>';
                        echo '  </form>';
                        echo '</div>';
                    }
                } else {
                    // 4. Mensagem caso não haja nenhuma oferta no momento
                    echo "<p>Nenhuma oferta encontrada no momento.</p>";
                }
                ?>
            </div>
        </section>
    </div>
</div>

<?php
// Inclui o rodapé do seu site
include 'templates/footer.php';
?>