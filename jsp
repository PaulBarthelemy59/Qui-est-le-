<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Party Game - On commence sobre, on finit bourré</title>
    
    <!-- Liens vers les polices et scripts nécessaires -->
    <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@600;800&family=Nunito:wght@400;700;900&display=swap" rel="stylesheet">
    <script src="https://unpkg.com/peerjs@1.4.7/dist/peerjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"></script>

    <style>
        :root {
            --bg: #0f0c1b;
            --pu-d: #231942;
            --pu-l: #5e548e;
            --pk: #ff007f;
            --ye: #ffd166;
            --txt: #ffffff;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Nunito', sans-serif;
        }

        body {
            background-color: var(--bg);
            color: var(--txt);
            overflow-x: hidden;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* Arrière-plan dynamique */
        .background-fx {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            overflow: hidden;
        }

        .land-blob {
            position: absolute;
            background: linear-gradient(45deg, var(--pk), var(--pu-l));
            filter: blur(80px);
            border-radius: 50%;
            opacity: 0.3;
            animation: float 10s infinite alternate;
        }

        .blob1 { width: 300px; height: 300px; top: -50px; left: -50px; }
        .blob2 { width: 400px; height: 400px; bottom: -100px; right: -100px; animation-delay: -5s; }

        @keyframes float {
            0% { transform: translate(0, 0) scale(1); }
            100% { transform: translate(50px, 50px) scale(1.2); }
        }

        /* Structure des Écrans */
        .screen {
            width: 100%;
            max-width: 500px;
            padding: 2rem;
            text-align: center;
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
            transition: all 0.4s ease;
        }

        /* Cacher les écrans secondaires par défaut */
        .hidden {
            display: none !important;
            opacity: 0;
            transform: translateY(20px);
        }

        h1 {
            font-family: 'Baloo 2', cursive;
            font-size: 3rem;
            line-height: 1;
            color: var(--ye);
            text-shadow: 0 4px 0px var(--pk);
        }

        .slogan {
            font-style: italic;
            color: #a0a0c0;
            font-size: 1.1rem;
        }

        /* Présentation Gemini */
        .gemini-intro {
            background: rgba(35, 25, 66, 0.6);
            border: 2px solid var(--pu-l);
            border-radius: 20px;
            padding: 1.2rem;
            font-size: 0.95rem;
            text-align: left;
            box-shadow: 0 8px 24px rgba(0,0,0,0.3);
        }

        .gemini-intro h3 {
            color: var(--ye);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        /* Boutons */
        .btn-group {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .btn {
            background: linear-gradient(135deg, var(--pu-l), var(--pu-d));
            color: white;
            border: 3px solid var(--pu-l);
            padding: 1rem;
            font-size: 1.3rem;
            font-weight: 900;
            border-radius: 15px;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
            box-shadow: 0 5px 0px var(--pu-d);
        }

        .btn:active {
            transform: translateY(5px);
            box-shadow: 0 0px 0px transparent;
        }

        .btn-main {
            background: linear-gradient(135deg, var(--pk), #d0006f);
            border-color: var(--pk);
            box-shadow: 0 5px 0px #800045;
        }

        /* Formulaires */
        .form-group {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
            text-align: left;
        }

        input {
            width: 100%;
            padding: 1rem;
            border-radius: 12px;
            border: 2px solid var(--pu-l);
            background: var(--pu-d);
            color: white;
            font-size: 1.1rem;
            outline: none;
        }

        input:focus {
            border-color: var(--pk);
        }
    </style>
</head>
<body>

    <!-- Effets de fond -->
    <div class="background-fx">
        <div class="land-blob blob1"></div>
        <div class="land-blob blob2"></div>
    </div>

    <!-- ================= ÉCRAN D'ACCUEIL ================= -->
    <div id="landing-screen" class="screen">
        <div>
            <h1>PARTY GAME 🍻</h1>
            <p class="slogan">« On commence sobre, on finit bourré. Pas d'échappatoire. »</p>
        </div>

        <!-- Bloc de présentation Gemini -->
        <div class="gemini-intro">
            <h3>✨ Briefing de Gemini :</h3>
            <p>Bienvenue dans le jeu ultime de vos soirées ! Pas besoin d'application à télécharger : un téléphone suffit. Un joueur <strong>héberge</strong> la partie sur sa maman d'écran (PC/TV), les autres scanne le QR code et <strong>rejoignent</strong> avec leur smartphone. Préparez-vous à voter, clasher et trinquer !</p>
        </div>

        <div class="btn-group">
            <button id="btn-to-join" class="btn btn-main">🚀 REJOINDRE UNE PARTIE</button>
            <button id="btn-to-host" class="btn">🏠 HÉBERGER LA SOIRÉE</button>
        </div>
    </div>

    <!-- ================= ÉCRAN REJOINDRE ================= -->
    <div id="join-screen" class="screen hidden">
        <h1>REJOINDRE 👋</h1>
        <p>Entre tes infos pour entrer dans l'arène :</p>
        
        <div class="form-group">
            <label>Ton super Pseudo :</label>
            <input type="text" id="player-name" placeholder="Ex: Jean-Mich-Mich">
        </div>

        <div class="form-group">
            <label>Code de la partie :</label>
            <input type="text" id="room-code" placeholder="Ex: ABCD">
        </div>

        <div class="btn-group">
            <button id="btn-confirm-join" class="btn btn-main">C'EST PARTI !</button>
            <button class="btn btn-back">⬅️ RETOUR</button>
        </div>
    </div>

    <!-- ================= ÉCRAN HÉBERGER ================= -->
    <div id="host-screen" class="screen hidden">
        <h1>HÉBERGEMENT 👑</h1>
        <p>Création de la salle en cours...</p>
        <div id="qrcode-container" style="background: white; padding: 10px; border-radius: 10px; display: inline-block; margin: 10px auto;"></div>
        <p>Code de la salle : <strong id="display-room-code" style="color: var(--ye); font-size: 1.5rem;">GÉNÉRATION...</strong></p>
        
        <div class="btn-group">
            <button class="btn btn-back">⬅️ ANNULER</button>
        </div>
    </div>

    <!-- ================= LOGIQUE JAVASCRIPT ================= -->
    <script>
        // Récupération des éléments HTML
        const landingScreen = document.getElementById('landing-screen');
        const joinScreen = document.getElementById('join-screen');
        const hostScreen = document.getElementById('host-screen');

        const btnToJoin = document.getElementById('btn-to-join');
        const btnToHost = document.getElementById('btn-to-host');
        const backButtons = document.querySelectorAll('.btn-back');

        // CLIC SUR REJOINDRE : Masque l'accueil et affiche le formulaire de connexion
        btnToJoin.addEventListener('click', () => {
            landingScreen.classList.add('hidden');
            joinScreen.classList.remove('hidden');
        });

        // CLIC SUR HÉBERGER : Masque l'accueil et simule l'ouverture d'une salle
        btnToHost.addEventListener('click', () => {
            landingScreen.classList.add('hidden');
            hostScreen.classList.remove('hidden');
            
            // Simulation d'un code de salle aléatoire pour l'exemple
            const fakeCode = Math.random().toString(36).substring(2, 6).toUpperCase();
            document.getElementById('display-room-code').innerText = fakeCode;
        });

        // BOUTONS RETOUR : Permettent de revenir à l'écran d'accueil
        backButtons.forEach(button => {
            button.addEventListener('click', () => {
                joinScreen.classList.add('hidden');
                hostScreen.classList.add('hidden');
                landingScreen.classList.remove('hidden');
            });
        });
    </script>
</body>
</html>
