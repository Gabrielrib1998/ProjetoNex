<?php
include 'auth.php';
include '../db_connect.php';
include 'templates/header.php';

// Consulta corrigida para buscar por 'tipo'
$sql = "SELECT id, nome, email, data_cadastro FROM usuarios WHERE tipo = 'cliente' ORDER BY id DESC";
$result = $conn->query($sql);

// Verificação de erro na consulta
if ($result === false) {
    die("Erro na consulta SQL: " . $conn->error);
}
?>

<div class="admin-header">
    <h1>Gerenciar Usuários</h1>
</div>

<table class="admin-table">
    <thead>
        <tr>
            <th>ID</th>
            <th>Nome</th>
            <th>Email</th>
            <th>Data de Cadastro</th>
            <th>Ações</th>
        </tr>
    </thead>
    <tbody>
        <?php if ($result && $result->num_rows > 0): ?>
            <?php while($row = $result->fetch_assoc()): ?>
                <tr>
                    <td data-label="ID"><?php echo $row['id']; ?></td>
                    <td data-label="Nome"><?php echo htmlspecialchars($row['nome']); ?></td>
                    <td data-label="Email"><?php echo htmlspecialchars($row['email']); ?></td>
                    <td data-label="Data de Cadastro"><?php echo date('d/m/Y', strtotime($row['data_cadastro'])); ?></td>
                    <td data-label="Ações" class="actions">
    <a href="editar_usuario.php?id=<?php echo $row['id']; ?>" title="Editar" class="action-btn">
        <i class="fas fa-edit"></i>
    </a>
</td>
                </tr>
            <?php endwhile; ?>
        <?php else: ?>
            <tr>
                <td colspan="5" style="text-align: center;">Nenhum usuário encontrado.</td>
            </tr>
        <?php endif; ?>
    </tbody>
</table>

<?php 
include 'templates/footer.php'; 
$conn->close();
?>