# Documentazione del progetto Workout App

## 1. Panoramica
Workout App è un progetto Flutter che organizza piani di allenamento, workout, esercizi e sessioni di training, con architettura a feature e gestione dello stato tramite BLoC. L’avvio dell’app configura le dipendenze e registra i BLoC principali (Plan, Workout, Exercise, Training) prima di montare il router principale dell’applicazione.【F:lib/main.dart†L1-L83】

## 2. Architettura e organizzazione del codice
### 2.1 Struttura a feature (Clean Architecture)
Ogni feature segue una suddivisione in:
- **data** (datasource locale, model, repository implementation)
- **domain** (entity, repository astratta, use case)
- **presentation** (BLoC, pagine, widget, form)

Esempi concreti per feature:
- **Plan**: datasource locale e repository in `data`, use case in `domain`, BLoC e pagine in `presentation`.【F:lib/features/plan/data/datasources/plan_local_datasource.dart†L1-L56】【F:lib/features/plan/domain/usecases/get_plans_usecase.dart†L1-L20】【F:lib/features/plan/presentation/bloc/plan_bloc.dart†L1-L35】
- **Workout**: datasource locale e repository in `data`, use case in `domain`, BLoC e pagine in `presentation`.【F:lib/features/workout/data/datasources/workout_local_datasource.dart†L1-L72】【F:lib/features/workout/domain/usecases/get_workouts_usecase.dart†L1-L20】【F:lib/features/workout/presentation/bloc/workout_bloc.dart†L1-L35】
- **Exercises**: datasource locale e repository in `data`, use case in `domain`, BLoC e pagine in `presentation`.【F:lib/features/exercises/data/datasources/workout_local_datasource.dart†L1-L90】【F:lib/features/exercises/domain/usecases/get_exercises_usecase.dart†L1-L20】【F:lib/features/exercises/presentation/bloc/exercise_bloc.dart†L1-L35】
- **Training**: datasource locale e repository in `data`, use case in `domain`, BLoC e pagine in `presentation`.【F:lib/features/training/data/datasources/training_local_datasource.dart†L1-L90】【F:lib/features/training/domain/usecase/get_train_ex_list_usecase.dart†L1-L20】【F:lib/features/training/presentation/bloc/training_bloc.dart†L1-L44】
- **Home**: pagina di navigazione con tab per Plan ed Exercises.【F:lib/features/home/presentation/pages/home_page.dart†L1-L45】

### 2.2 Core e routing
Il routing centrale usa `go_router` per gestire le rotte principali (home, lista workouts per piano, esercizi, training).【F:lib/core/router.dart†L1-L42】

### 2.3 Dependency Injection
La DI è gestita con `get_it` + `injectable`, con moduli dedicati per il database locale e il client HTTP Dio.【F:lib/injection.dart†L1-L15】【F:lib/injection_module.dart†L1-L20】

## 3. Database
Il database locale è definito con Drift (`AppDatabase`) e include quattro tabelle principali:
- **Plan** (id, name)
- **Workout** (id, name, planId)
- **Exercise** (id, name, description, targetMuscle)
- **Training** (id, workoutId, exerciseId, sets, reps, restSeconds, rpe)

Le relazioni principali sono:
- **Plan 1:N Workout**
- **Workout 1:N Training**
- **Exercise 1:N Training**

Queste tabelle e relazioni sono definite in `database.dart` e gestite tramite Drift e migrazioni in `AppDatabase`.【F:lib/database.dart†L1-L88】

### 3.1 Diagramma draw.io del database
Il diagramma è salvato in:
- `docs/diagrams/database.drawio`

Puoi aprirlo con [diagrams.net](https://app.diagrams.net/) scegliendo **File → Open** e selezionando il file.

## 4. Struttura delle feature (diagramma)
Il diagramma delle feature mostra il raggruppamento per domini (Plan, Workout, Exercises, Training, Home) e la struttura a livelli (data/domain/presentation) per ogni feature.

### 4.1 Diagramma draw.io della struttura delle feature
Il diagramma è salvato in:
- `docs/diagrams/features.drawio`

Puoi aprirlo con [diagrams.net](https://app.diagrams.net/) scegliendo **File → Open** e selezionando il file.

## 5. Navigazione principale
- **Home** (`/`): contiene tab per *Plans* ed *Exercises*.【F:lib/core/router.dart†L10-L23】【F:lib/features/home/presentation/pages/home_page.dart†L1-L45】
- **Workouts** (`/plans/:planId/workouts`): lista workout collegati a un piano.【F:lib/core/router.dart†L17-L26】
- **Exercises** (`/exercises`): lista esercizi.【F:lib/core/router.dart†L27-L31】
- **Training** (`/workouts/:planId/:workoutId/training`): esercizi di training associati a un workout e piano.【F:lib/core/router.dart†L32-L41】

## 6. Dove aggiornare la documentazione
- Per modifiche ai dati o alle relazioni, aggiornare `database.dart` e rigenerare il diagramma `docs/diagrams/database.drawio`.
- Per nuove feature o cambiamenti architetturali, aggiornare `docs/diagrams/features.drawio` e la sezione **Struttura a feature** di questo documento.
