<?php
// Este arquivo pode incluir o auth.php no futuro, se necessário.
// session_start(); // O auth.php já deve iniciar a sessão.
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Painel Administrativo - NexCommerce</title>
    <link rel="icon" href="../favicon.png" type="image/png">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    
    <link rel="stylesheet" href="admin_style.css">
</head>
<body>
    <div class="admin-container">
        <header class="admin-top-header">
            <div class="header-brand">
                <a href="index.php">
                    <img src="../assets/img/logo.png" alt="NexCommerce Logo">
                    <span class="brand-text-desktop">NexCommerce Admin</span>
                </a>
            </div>
            <nav class="admin-top-nav desktop-nav">
                <a href="index.php" class="<?php echo (basename($_SERVER['PHP_SELF']) == 'index.php') ? 'active' : ''; ?>">Dashboard</a>
                <a href="produtos.php" class="<?php echo (basename($_SERVER['PHP_SELF']) == 'produtos.php' || basename($_SERVER['PHP_SELF']) == 'produto_form.php') ? 'active' : ''; ?>">Produtos</a>
                <a href="pedidos.php" class="<?php echo (basename($_SERVER['PHP_SELF']) == 'pedidos.php' || basename($_SERVER['PHP_SELF']) == 'pedido_detalhes.php') ? 'active' : ''; ?>">Pedidos</a>
                <a href="usuarios.php" class="<?php echo (basename($_SERVER['PHP_SELF']) == 'usuarios.php') ? 'active' : ''; ?>">Usuários</a>
            </nav>
            <div class="header-actions desktop-actions">
                <a href="../index.php" target="_blank" class="btn btn-secondary">Ver Site</a>
                <a href="logout.php" class="btn btn-logout">Sair</a>
            </div>
        </header>

        <main class="admin-main-content">