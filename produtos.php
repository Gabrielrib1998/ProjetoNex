<?php
// Inclui o header e a conexão com o banco
include 'templates/header.php';
include 'db_connect.php';

// Inicializa a variável de categoria e o título da página
$categoria_selecionada = null;
$titulo_pagina = "Todos os Produtos";
$sql = "SELECT * FROM produtos ORDER BY nome ASC";

// Verifica se uma categoria foi passada pela URL
if (isset($_GET['categoria']) && !empty($_GET['categoria'])) {
    $categoria_selecionada = $_GET['categoria'];
    $titulo_pagina = "Produtos da Categoria: " . htmlspecialchars($categoria_selecionada);
    
    // Prepara a consulta SQL de forma segura para evitar SQL Injection
    $sql = "SELECT * FROM produtos WHERE categoria = ? ORDER BY nome ASC";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $categoria_selecionada);
    $stmt->execute();
    $result = $stmt->get_result();

} else {
    // Se nenhuma categoria for especificada, executa a consulta para todos os produtos
    $result = $conn->query($sql);
}
?>

<div class="container" style="padding-top: 40px; padding-bottom: 40px;">
    <h1 class="section-title-highlight"><?php echo $titulo_pagina; ?></h1>
    
    <div class="product-grid" style="margin-top: 30px;">
        <?php
        // Verifica se a consulta retornou resultados
        if ($result && $result->num_rows > 0) {
            // Loop para exibir cada produto
            while($row = $result->fetch_assoc()) {
                echo '<div class="product-card">';
                echo '    <a href="produto.php?id=' . $row["id"] . '">';
                echo '        <div class="product-image-container">';
                echo '            <img src="' . htmlspecialchars($row["imagem_url"]) . '" alt="' . htmlspecialchars($row["nome"]) . '">';
                if ($row["em_oferta"]) {
                    echo '            <span class="sale-badge">Oferta!</span>';
                }
                echo '        </div>';
                echo '        <h3>' . htmlspecialchars($row["nome"]) . '</h3>';
                if (!empty($row["preco_antigo"])) {
                    echo '        <p class="price-old">R$ ' . number_format($row["preco_antigo"], 2, ',', '.') . '</p>';
                }
                echo '        <p class="price">R$ ' . number_format($row["preco"], 2, ',', '.') . '</p>';
                echo '    </a>';
                echo '    <form action="carrinho_acoes.php" method="POST" style="margin-top: 10px;">';
                echo '        <input type="hidden" name="action" value="add">';
                echo '        <input type="hidden" name="produto_id" value="' . $row["id"] . '">';
                echo '        <button type="submit" class="btn"><i class="fas fa-cart-plus"></i> Adicionar</button>';
                echo '    </form>';
                echo '</div>';
            }
        } else {
            // Mensagem exibida se nenhum produto for encontrado
            echo "<p>Nenhum produto encontrado nesta categoria.</p>";
        }
        ?>
    </div>
</div>

<?php
// Fecha a conexão com o banco e inclui o footer
if (isset($stmt)) {
    $stmt->close();
}
$conn->close();
include 'templates/footer.php';
?>