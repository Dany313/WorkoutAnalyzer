# WorkoutAnalyzer

WorkoutAnalyzer è un'applicazione mobile sviluppata in Flutter per la gestione avanzata degli allenamenti in palestra.
L'app permette agli atleti di creare piani personalizzati, sedute di allenamento, e gestire in modo flessibile sia esercizi singoli che **superserie**.

## 🏗 Architettura e Scelte Progettuali

L'applicazione è costruita seguendo rigorosamente i principi della **Clean Architecture** per garantire scalabilità, testabilità e separazione delle responsabilità.

Il progetto è suddiviso in 3 layer principali:
1. **Domain (Dominio)**: Contiene la logica di business pura e indipendente da framework o database.
   - Entità immutabili modellate con `freezed` (`WorkoutPlan`, `WorkoutSession`, `Exercise`, `ExerciseSet`).
   - L'entità `WorkoutItem` è definita come una `sealed class` (union type) che permette di rappresentare in maniera type-safe sia un esercizio singolo (`SingleExercise`) che una superserie (`Superset`), sfruttando il pattern matching nativo.
   - Astrazioni dei Repository (es. `WorkoutRepository`).
2. **Data (Dati)**: Gestisce il recupero e la persistenza dei dati.
   - Implementazione del repository tramite `SqliteWorkoutRepositoryImpl`.
   - **Persistenza**: Abbiamo scelto **SQLite (`sqflite`)** implementando un approccio "Documentale". Data l'estrema nidificazione dei dati (Piano > Seduta > Item > Esercizio > Serie), normalizzare il database in 5 o più tabelle avrebbe reso le operazioni lente e il codice eccessivamente verboso. Pertanto, utilizziamo una tabella in SQLite che sfrutta la serializzazione JSON nativa generata da `freezed` per salvare l'intero "Albero" dell'allenamento in un'unica operazione efficiente, mantenendo la scalabilità di SQL.
3. **Presentation (Presentazione)**: La UI visibile all'utente.
   - Il pattern architetturale della UI è l'**MVVM** implementato tramite **Bloc/Cubit** (`flutter_bloc`). Il `WorkoutCubit` agisce come ViewModel, orchestrando le chiamate al dominio ed esponendo gli stati reattivi.
   - Interfacce pulite costruite con il framework di Material Design 3.

## 🛠 Tecnologie Utilizzate

- **Flutter / Dart 3**: UI cross-platform e logica di business.
- **`flutter_bloc`**: Per la gestione dello stato reattiva (utilizzo specifico di `Cubit`).
- **`freezed` & `json_serializable`**: Per le entità immutabili, deep-copy, data-classes e generazione serializzazione JSON.
- **`go_router`**: Per una navigazione dichiarativa e sicura basata su path.
- **`get_it`**: Per la Dependency Injection, mantenendo i componenti altamente disaccoppiati e facilmente testabili o sostituibili.
- **`dartz`**: Per la gestione funzionale degli errori (uso di `Either<Failure, Success>`).
- **`sqflite`**: Database SQLite locale per la persistenza dei dati sul dispositivo.

## 🚀 Come avviare il progetto

Per far funzionare correttamente il database locale (che non è supportato per il web via browser nativo), esegui l'app su macOS nativo o in un simulatore iOS/Android:

1. Installa le dipendenze:
   ```bash
   flutter pub get
   ```
2. Nel caso si apportino modifiche ai modelli (file `freezed`), rigenera il codice con:
   ```bash
   dart run build_runner build -d
   ```
3. Avvia l'app (es. su macOS o iOS Simulator):
   ```bash
   flutter run -d macos
   # oppure
   flutter run
   ```

## 📱 Flusso Utente

1. **Dashboard Piani**: Lista di tutti i piani di allenamento creati.
2. **Dettaglio Piano**: Lista delle sedute (giornate) all'interno dello specifico piano.
3. **Dettaglio Seduta**: L'elenco degli esercizi e delle superserie della giornata, con un'interfaccia sintetica che riporta unicamente nomi e descrizioni.
4. **Dettaglio Esercizio/Superserie**: Una vista dedicata dove si inseriscono i dettagli operativi per ogni singolo *set* (ripetizioni, kg, recupero), e dove si aggregano più esercizi per formare una superserie.
