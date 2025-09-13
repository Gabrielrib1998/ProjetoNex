<?php
include 'auth.php';
include '../db_connect.php';

// --- BUSCA DE ESTATÍSTICAS ---
$total_pedidos = $conn->query("SELECT COUNT(*) as total FROM pedidos")->fetch_assoc()['total'];
$total_vendas = $conn->query("SELECT SUM(valor_total) as total FROM pedidos")->fetch_assoc()['total'];
$total_usuarios = $conn->query("SELECT COUNT(*) as total FROM usuarios WHERE tipo = 'cliente'")->fetch_assoc()['total'];
$total_produtos = $conn->query("SELECT COUNT(*) as total FROM produtos")->fetch_assoc()['total'];


// --- NOVA LÓGICA PARA PORCENTAGEM DOS PRODUTOS MAIS VENDIDOS ---
// Primeiro, calculamos o total de itens vendidos na loja
$total_itens_vendidos_result = $conn->query("SELECT SUM(quantidade) as total_geral FROM pedido_items");
$total_itens_vendidos = $total_itens_vendidos_result->fetch_assoc()['total_geral'] ?? 0;

// Depois, buscamos os 5 produtos mais vendidos
$sql_mais_vendidos = "
    SELECT p.nome, SUM(pi.quantidade) as total_vendido
    FROM pedido_items pi
    JOIN produtos p ON pi.produto_id = p.id
    GROUP BY p.id, p.nome
    ORDER BY total_vendido DESC
    LIMIT 5
";
$result_mais_vendidos = $conn->query($sql_mais_vendidos);

$produtos_campeoes = [];
if ($result_mais_vendidos && $total_itens_vendidos > 0) {
    while ($row = $result_mais_vendidos->fetch_assoc()) {
        $porcentagem = ($row['total_vendido'] / $total_itens_vendidos) * 100;
        $row['porcentagem'] = round($porcentagem, 2);
        $produtos_campeoes[] = $row;
    }
}
// --- FIM DA LÓGICA DE PORCENTAGEM ---


include 'templates/header.php';
?>

<div class="admin-header">
    <h1>Dashboard</h1>
    <span>Bem-vindo, <?php echo htmlspecialchars($_SESSION['admin_nome']); ?>!</span>
</div>

<div class="stats-grid">
    <div class="stat-card">
        <h3>Total de Vendas</h3>
        <p class="stat-number">R$ <?php echo number_format($total_vendas ?? 0, 2, ',', '.'); ?></p>
    </div>
    <div class="stat-card">
        <h3>Pedidos Recebidos</h3>
        <p class="stat-number"><?php echo $total_pedidos ?? 0; ?></p>
    </div>
    <div class="stat-card">
        <h3>Clientes Cadastrados</h3>
        <p class="stat-number"><?php echo $total_usuarios ?? 0; ?></p>
    </div>
    <div class="stat-card">
        <h3>Produtos na Loja</h3>
        <p class="stat-number"><?php echo $total_produtos ?? 0; ?></p>
    </div>
</div>

<div class="top-products-container">
    <h2><i class="fas fa-star"></i> Produtos Campeões de Vendas</h2>
    <?php if (!empty($produtos_campeoes)): ?>
        <ul class="top-products-list">
            <?php foreach ($produtos_campeoes as $produto): ?>
                <li>
                    <span class="product-name"><?php echo htmlspecialchars($produto['nome']); ?></span>
                    <div class="progress-bar-container">
                        <div class="progress-bar" style="width: <?php echo $produto['porcentagem']; ?>%;"></div>
                    </div>
                    <span class="product-percentage"><?php echo $produto['porcentagem']; ?>%</span>
                </li>
            <?php endforeach; ?>
        </ul>
        <small>*Porcentagem baseada no total de unidades vendidas.</small>
    <?php else: ?>
        <p>Ainda não há dados de vendas suficientes para exibir.</p>
    <?php endif; ?>
</div>


<?php 
$conn->close();
include 'templates/footer.php'; 
?>