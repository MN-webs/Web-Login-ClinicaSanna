<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Sistema Clínico Sanna - Panel Central</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 0; background-color: #f0f4f8; color: #333; }
        .navbar { background-color: #004085; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .navbar h2 { margin: 0; font-weight: 600; font-size: 22px; }
        .btn-logout { background-color: #dc3545; color: white; border: none; padding: 10px 18px; cursor: pointer; border-radius: 20px; font-weight: bold; transition: 0.3s; }
        .btn-logout:hover { background-color: #bd2130; }
        .menu-container { display: flex; padding: 40px 20px; gap: 25px; justify-content: center; margin-top: 30px; flex-wrap: wrap; }
        
        .card { background: white; border-radius: 12px; border-top: 5px solid #00a896; box-shadow: 0 4px 15px rgba(0, 64, 133, 0.05); width: 240px; padding: 25px; text-align: center; cursor: pointer; transition: all 0.3s ease; }
        .card:hover { transform: translateY(-8px); box-shadow: 0 12px 24px rgba(0, 64, 133, 0.12); background-color: #f8fbfd; }
        .card h3 { color: #004085; margin-top: 0; font-size: 18px; font-weight: 600; }
        .card p { color: #666; font-size: 13.5px; line-height: 1.5; }
        
        .tarjeta-menu-container { position: relative; display: inline-block; }
        .tarjeta-menu-container .card { border-top: 5px solid #0056b3; }

        .menu-desplegable { display: none; position: absolute; top: 105%; left: 0; background-color: white; min-width: 100%; box-shadow: 0px 10px 25px rgba(0,0,0,0.15); border: 1px solid #d1dbec; border-radius: 12px; z-index: 100; overflow: hidden; }
        .opcion-menu { color: #495057; padding: 14px 18px; text-decoration: none; display: flex; align-items: center; border-bottom: 1px solid #f1f5f9; font-size: 14px; font-weight: 500; transition: 0.2s; }
        .opcion-menu:hover { background-color: #edf4fc; color: #004085; }
        .opcion-menu:last-child { border-bottom: none; }
        .icono-check { width: 8px; height: 8px; background-color: #00a896; border-radius: 50%; margin-right: 12px; display: inline-block; flex-shrink: 0; }

        /* Estilos del Modal Quirúrgico de Citas */
        .modal-overlay { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5); z-index: 200; backdrop-filter: blur(2px); }
        .modal-citas { display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background: white; border-radius: 16px; box-shadow: 0 10px 30px rgba(0,0,0,0.2); width: 400px; z-index: 201; overflow: hidden; }
        .modal-header { background-color: #004085; color: white; padding: 15px 20px; font-size: 18px; font-weight: bold; }
        .modal-body { padding: 20px; }
        .modal-footer { padding: 12px 20px; background-color: #f8f9fa; display: flex; justify-content: flex-end; border-top: 1px solid #eee; }
        .btn-cerrar { background-color: #00a896; color: white; border: none; padding: 8px 16px; border-radius: 6px; cursor: pointer; font-weight: bold; }
        .btn-cerrar:hover { background-color: #008f80; }
        .cita-item { background: #f4f7f6; padding: 12px; border-left: 4px solid #004085; margin-bottom: 10px; border-radius: 0 8px 8px 0; font-size: 13.5px; }
    </style>
</head>
<body>

    <%
        // Recibe las citas enviadas desde el Servlet de forma segura
        List<String> citas = (List<String>) request.getAttribute("listaCitas");
        int totalCitas = (citas != null) ? citas.size() : 0;
    %>

    <div class="navbar">
        <h2>Clínica Sanna - Panel Central</h2>
        <button class="btn-logout" onclick="window.location='index.jsp'">Cerrar Sesión</button>
    </div>

    <div class="menu-container">
        <div class="card" onclick="alert('Abriendo Gestión...')">
            <h3>Gestión Clínica</h3>
            <p>Administración de pacientes, citas y reportes médicos.</p>
        </div>
        
        <div class="card" onclick="alert('Abriendo Sedes...')">
            <h3>Sedes Cercanas</h3>
            <p>Consulta las clínicas e instalaciones disponibles en Lima.</p>
        </div>
        
        <div class="card" onclick="alert('Abriendo Soporte...')">
            <h3>Ayuda</h3>
            <p>Soporte técnico, manuales de usuario y preguntas frecuentes.</p>
        </div>

        <div class="tarjeta-menu-container">
            <div class="card" id="tarjetaPerfil" onclick="conmutarMenu()">
                <h3>Perfil de Usuario</h3>
                <p>Ver y actualizar tus datos de usuario, cargo y credenciales.</p>
            </div>
            
            <div class="menu-desplegable" id="miMenuDesplegable">
                <a href="perfil.jsp" class="opcion-menu">
                    <span class="icono-check"></span> Correo electrónico
                </a>
                <a href="#" class="opcion-menu" onclick="abrirModalCitas()">
                    <span class="icono-check"></span> Citas Pendientes (<%= totalCitas %>)
                </a>
            </div>
        </div>
    </div>
    
    <div class="modal-overlay" id="capaOscura" onclick="cerrarModalCitas()"></div>
    <div class="modal-citas" id="ventanaCitas">
        <div class="modal-header">Citas Médicas Pendientes</div>
        <div class="modal-body">
            <% if (citas == null || citas.isEmpty()) { %>
                <p style="color: #666; text-align: center;">No registras citas médicas pendientes.</p>
            <% } else { 
                for (String cita : citas) { %>
                    <div class="cita-item"><%= cita %></div>
                <% } 
            } %>
        </div>
        <div class="modal-footer">
            <button class="btn-cerrar" onclick="cerrarModalCitas()">Entendido</button>
        </div>
    </div>
    
    <script>
        function conmutarMenu() {
            var menu = document.getElementById("miMenuDesplegable");
            menu.style.display = (menu.style.display === "block") ? "none" : "block";
        }

        function abrirModalCitas() {
            document.getElementById('ventanaCitas').style.display = 'block';
            document.getElementById('capaOscura').style.display = 'block';
            document.getElementById('miMenuDesplegable').style.display = 'none';
        }

        function cerrarModalCitas() {
            document.getElementById('ventanaCitas').style.display = 'none';
            document.getElementById('capaOscura').style.display = 'none';
        }

        window.onclick = function(event) {
            if (!event.target.matches('#tarjetaPerfil') && !event.target.closest('#tarjetaPerfil')) {
                var menu = document.getElementById("miMenuDesplegable");
                if (menu && menu.style.display === "block") {
                    menu.style.display = "none";
                }
            }
        }
    </script> 
</body>
</html>